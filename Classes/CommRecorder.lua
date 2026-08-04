local L = Gargul_L;

---@type GL
local _, GL = ...;

-- Opt-in recorder for Gargul's addon comms, exported via /gl commtrace.

---@class CommRecorder
GL.CommRecorder = {
    _initialized = false,
    _trafficHooked = false,

    enabled = false,

    MAX_ENTRIES = 4000, -- ring buffer cap; oldest entry is overwritten when full
    MAX_BYTES = 512 * 1024, -- secondary guard: halve the buffer if it exceeds this
    AUTO_EXPIRE_SECONDS = 12 * 60 * 60, -- auto-disable if left running longer than this

    Entries = {},
    nextIndex = 1,
    count = 0,
    approxBytes = 0,

    Session = {},
    Traffic = { gargul = 0, other = 0, gargulBytes = 0, otherBytes = 0, },

    rollAnnounceAt = nil, -- set on roll announce, used to measure the initiator's echo
};

---@type CommRecorder
local CommRecorder = GL.CommRecorder;

-- Direction/kind codes
CommRecorder.Kind = {
    send = 1,
    sent = 2, -- send completed (send callback)
    recv = 3,
    drop = 4,
    rolloff = 5,
    confirm = 6,
    response = 7,
};

-- Drop reason codes
CommRecorder.DropReason = {
    decompressFail = 1,
    notForMe = 2,
    tamper = 3,
    senderOutdated = 4,
    notBackwardsCompatible = 5,
    missingAction = 6,
    missingID = 7,
    confirmTimeout = 8,
    unknownAction = 9,
};

local PriorityCode = { ALERT = 1, NORMAL = 2, BULK = 3, };
local ChannelCode = { RAID = 1, PARTY = 2, WHISPER = 3, GUILD = 4, INSTANCE_CHAT = 5, };

-- Rolled into summary counters instead of flooding the ring buffer.
local Actions = GL.Data.Constants.Comm.Actions or {};
local AggregatedActions = {
    [Actions.bidOnGDKPMultiAuction] = true,
    [Actions.announceChangesForGDKPMultiAuction] = true,
    [Actions.requestRunningGDKPMultiAuctionHash] = true,
    [Actions.requestRunningGDKPMultiAuctionDetails] = true,
};

---@return nil
function CommRecorder:_init()
    if (self._initialized) then
        return;
    end
    self._initialized = true;

    self.enabled = GL.Settings:get("commTraceEnabled", false) == true;

    -- Auto-expire if the recorder was left on for too long
    if (self.enabled) then
        local enabledAt = tonumber(GL.Settings:get("commTraceEnabledAt", 0)) or 0;
        if (enabledAt > 0 and (time() - enabledAt) > self.AUTO_EXPIRE_SECONDS) then
            self.enabled = false;
            GL.Settings:set("commTraceEnabled", false);
            GL:warning(L["Gargul comm recorder was automatically turned off (it had been running for a while). Re-enable it in Settings > Advanced if you still need it."]);
        end
    end

    -- Hooked once regardless of state; the hook bails when disabled
    self:hookTraffic();

    GL.Events:register("CommRecorderLogoutListener", "PLAYER_LOGOUT", function ()
        self:flush();
    end);

    -- Measure the initiator's own roll-off echo round-trip
    GL.Events:register("CommRecorderRollStartedListener", "GL.ROLLOFF_STARTED", function ()
        if (not self.enabled or not self.rollAnnounceAt) then
            return;
        end

        self:record({ k = self.Kind.rolloff, ev = "echo", l = self:msSince(self.rollAnnounceAt), });
        self.rollAnnounceAt = nil;
    end);

    GL.Events:register("CommRecorderRollFailedListener", "GL.ROLLOFF_START_FAILED", function ()
        if (not self.enabled) then
            return;
        end

        self:record({ k = self.Kind.rolloff, ev = "failed", l = self.rollAnnounceAt and self:msSince(self.rollAnnounceAt) or nil, });
        self.rollAnnounceAt = nil;
    end);

    if (self.enabled) then
        self:startSession();
    end
end

--- Enable/disable the recorder at runtime (from the settings checkbox).
---@param enabled boolean
---@return nil
function CommRecorder:setEnabled(enabled)
    enabled = enabled == true;

    if (enabled == self.enabled) then
        return;
    end

    self.enabled = enabled;

    if (enabled) then
        GL.Settings:set("commTraceEnabledAt", time());
        self:startSession();
        GL:success(L["Gargul comm recorder started. Reproduce the issue, then run |c00%s/gl commtrace|r and share the output."]:format(GL.Data.Constants.commandHexColor));
    else
        GL:notice(L["Gargul comm recorder stopped."]);
    end
end

--- Clear the buffer and start a fresh session.
---@return nil
function CommRecorder:startSession()
    self.Entries = {};
    self.nextIndex = 1;
    self.count = 0;
    self.approxBytes = 0;
    self.rollAnnounceAt = nil;

    -- nBypass counts from login, so we need a baseline to measure this session against
    local CTL = _G.ChatThrottleLib;
    local bypass = CTL and tonumber(CTL.nBypass) or nil;

    self.Traffic = {
        gargul = 0,
        other = 0,
        gargulBytes = 0,
        otherBytes = 0,
        ByPrefix = {},
        Bypass = bypass and { first = bypass, firstAt = GetTime(), } or nil,
    };
    self.Aggregates = {};
    self.idCounter = 0;
    self.Session = {
        startedAt = time(),
        startTime = GetTime(),
        version = GL.version,
        groupSize = GL:count(GL.User:groupMembers() or {}),
    };
end

--- Close off the session's duration and bypass counters. Call before exporting or persisting.
---@return nil
function CommRecorder:stampSession()
    self.Session.durationMs = self:msSince(self.Session.startTime or GetTime());

    local Bypass = self.Traffic and self.Traffic.Bypass;
    local CTL = _G.ChatThrottleLib;
    if (not Bypass or not CTL) then
        return;
    end

    Bypass.last = tonumber(CTL.nBypass) or Bypass.first;
    Bypass.seconds = (GetTime() or 0) - (Bypass.firstAt or 0);
    Bypass.maxCPS = tonumber(CTL.MAX_CPS);
end

--- Next trace ID for an outgoing message. A bare counter keeps the payload
--- overhead minimal; our own echo carries the same value, and other senders
--- are distinguished by their sender name in the log.
---@return number
function CommRecorder:nextID()
    self.idCounter = (self.idCounter or 0) + 1;
    return self.idCounter;
end

--- Milliseconds elapsed since a GetTime() timestamp (integer).
---@param since number
---@return number
function CommRecorder:msSince(since)
    return floor(((GetTime() or 0) - (since or 0)) * 1000 + 0.5);
end

--- Estimate how many addon-channel chunks a payload of `bytes` needs.
---@param bytes number
---@return number
function CommRecorder:chunkCount(bytes)
    bytes = tonumber(bytes) or 0;
    if (bytes <= 255) then
        return bytes > 0 and 1 or 0;
    end

    return ceil(bytes / 254);
end

--- Snapshot ChatThrottleLib queue depth and bandwidth (shows if sends are stuck).
---@return table|nil
function CommRecorder:ctlSnapshot()
    local CTL = _G.ChatThrottleLib;
    if (not CTL or not CTL.Prio) then
        return nil;
    end

    local function depth(prioName)
        local Prio = CTL.Prio[prioName];
        if (not Prio or not Prio.ByName) then
            return 0;
        end

        local messages = 0;
        for _, pipe in pairs(Prio.ByName) do
            messages = messages + #pipe;
        end

        return messages;
    end

    return {
        av = floor(tonumber(CTL.avail) or 0),
        qa = depth("ALERT"),
        qn = depth("NORMAL"),
        qb = depth("BULK"),
        by = floor(tonumber(CTL.nBypass) or 0),
        burst = CTL.BURST,
        cps = CTL.MAX_CPS,
    };
end

--- Rough byte size of an entry, used only for the byte-budget guard.
---@param Entry table
---@return number
local function roughSize(Entry)
    local size = 16;
    for k, v in pairs(Entry) do
        size = size + #tostring(k) + 4;
        local t = type(v);
        if (t == "string") then
            size = size + #v;
        elseif (t == "table") then
            size = size + 48;
        else
            size = size + 8;
        end
    end

    return size;
end

--- Collapse consecutive identical BULK spam (e.g. gear storms) so it can't
--- evict the interesting NORMAL/drop/roll-off rows.
---@param Prev table
---@param Entry table
---@return boolean
local function coalescable(Prev, Entry)
    if (not Prev or not Entry) then
        return false;
    end

    if (Entry.k ~= Prev.k) then
        return false;
    end

    if (Entry.k ~= CommRecorder.Kind.send and Entry.k ~= CommRecorder.Kind.recv) then
        return false;
    end

    -- BULK only
    if (Entry.p ~= 3 or Prev.p ~= 3) then
        return false;
    end

    if (Entry.a ~= Prev.a) then
        return false;
    end

    if (Entry.c ~= Prev.c) then
        return false;
    end

    return true;
end

--- Append an entry to the ring buffer.
---@param Entry table
---@return nil
function CommRecorder:record(Entry)
    if (not self.enabled) then
        return;
    end

    -- Aggregate high-frequency actions instead of ringing them, drops excepted
    if (Entry.k ~= self.Kind.drop and Entry.a and AggregatedActions[Entry.a]) then
        self:aggregate(Entry);
        return;
    end

    Entry.o = self:msSince(self.Session.startTime or GetTime());

    local lastIndex = (self.nextIndex - 1);
    if (lastIndex < 1) then
        lastIndex = self.count > 0 and self.MAX_ENTRIES or 0;
    end

    local Prev = lastIndex >= 1 and self.Entries[lastIndex] or nil;
    if (coalescable(Prev, Entry)) then
        Prev.cnt = (Prev.cnt or 1) + 1;
        Prev.o = Entry.o;
        Prev.b = (Prev.b or 0) + (Entry.b or 0);
        return;
    end

    self.Entries[self.nextIndex] = Entry;
    self.approxBytes = self.approxBytes + roughSize(Entry);

    self.nextIndex = self.nextIndex + 1;
    if (self.nextIndex > self.MAX_ENTRIES) then
        self.nextIndex = 1;
    end

    if (self.count < self.MAX_ENTRIES) then
        self.count = self.count + 1;
    end

    if (self.approxBytes > self.MAX_BYTES) then
        self:trimHalf();
    end
end

--- Roll an entry into a per-(action, kind) summary counter.
---@param Entry table
---@return nil
function CommRecorder:aggregate(Entry)
    self.Aggregates = self.Aggregates or {};

    local key = ("%s:%s"):format(Entry.a or 0, Entry.k or 0);
    local A = self.Aggregates[key];
    if (not A) then
        A = { a = Entry.a, k = Entry.k, count = 0, bytes = 0, latSum = 0, latCount = 0, latMax = 0, };
        self.Aggregates[key] = A;
    end

    A.count = A.count + 1;

    if (Entry.b) then
        A.bytes = A.bytes + Entry.b;
    end

    if (Entry.l) then
        A.latSum = A.latSum + Entry.l;
        A.latCount = A.latCount + 1;
        if (Entry.l > A.latMax) then
            A.latMax = Entry.l;
        end
    end
end

--- Drop the oldest half of the buffer when the byte budget is exceeded.
---@return nil
function CommRecorder:trimHalf()
    local Ordered = self:orderedEntries();
    local keepFrom = floor(#Ordered / 2) + 1;

    self.Entries = {};
    self.nextIndex = 1;
    self.count = 0;
    self.approxBytes = 0;

    for i = keepFrom, #Ordered do
        local Entry = Ordered[i];
        self.Entries[self.nextIndex] = Entry;
        self.approxBytes = self.approxBytes + roughSize(Entry);
        self.nextIndex = self.nextIndex + 1;
        self.count = self.count + 1;
    end
end

--- Return entries in chronological order (oldest -> newest).
---@return table
function CommRecorder:orderedEntries()
    local Ordered = {};

    if (self.count < self.MAX_ENTRIES) then
        -- Not wrapped: entries are already in order
        for i = 1, self.count do
            Ordered[#Ordered + 1] = self.Entries[i];
        end
    else
        -- Wrapped: oldest entry is at nextIndex
        for i = self.nextIndex, self.MAX_ENTRIES do
            Ordered[#Ordered + 1] = self.Entries[i];
        end
        for i = 1, self.nextIndex - 1 do
            Ordered[#Ordered + 1] = self.Entries[i];
        end
    end

    return Ordered;
end

--- Secure-hook the native send API to count outgoing traffic per addon prefix.
---@return nil
function CommRecorder:hookTraffic()
    if (self._trafficHooked or not _G.C_ChatInfo or not _G.C_ChatInfo.SendAddonMessage) then
        return;
    end
    self._trafficHooked = true;

    local gargulPrefix = GL.Data.Constants.Comm.channel;

    local function onSend(prefix, text)
        if (not self.enabled) then
            return;
        end

        prefix = tostring(prefix or "?");
        local size = strlen(tostring(text or ""));

        if (prefix == gargulPrefix) then
            self.Traffic.gargul = self.Traffic.gargul + 1;
            self.Traffic.gargulBytes = self.Traffic.gargulBytes + size;
        else
            self.Traffic.other = self.Traffic.other + 1;
            self.Traffic.otherBytes = self.Traffic.otherBytes + size;
        end

        self.Traffic.ByPrefix = self.Traffic.ByPrefix or {};
        local Bucket = self.Traffic.ByPrefix[prefix];
        if (not Bucket) then
            Bucket = { count = 0, bytes = 0, };
            self.Traffic.ByPrefix[prefix] = Bucket;
        end
        Bucket.count = Bucket.count + 1;
        Bucket.bytes = Bucket.bytes + size;
    end

    hooksecurefunc(_G.C_ChatInfo, "SendAddonMessage", function (prefix, text)
        onSend(prefix, text);
    end);

    if (_G.C_ChatInfo.SendAddonMessageLogged) then
        hooksecurefunc(_G.C_ChatInfo, "SendAddonMessageLogged", function (prefix, text)
            onSend(prefix, text);
        end);
    end
end

--- Persist the current session to SavedVariables, keeping one previous session.
---@return nil
function CommRecorder:flush()
    if (not self.enabled or not GL.DB or not GL.DB.CommTrace) then
        return;
    end

    -- Don't overwrite a stored capture with an empty session
    if (self.count < 1 and not (self.Aggregates and next(self.Aggregates))) then
        return;
    end

    self:stampSession();

    local Store = GL.DB.CommTrace;

    Store.Previous = {
        Meta = Store.Meta,
        Traffic = Store.Traffic,
        Entries = Store.Entries,
        Aggregates = Store.Aggregates,
    };

    Store.Meta = self.Session;
    Store.Traffic = self.Traffic;
    Store.Entries = self:orderedEntries();
    Store.Aggregates = self.Aggregates;
end

---@param action number|nil
---@param priority string|nil
---@param channel string|nil
---@param recipient string|nil
---@param bytes number|nil
---@param traceID number|nil
---@return nil
function CommRecorder:recordSend(action, priority, channel, recipient, bytes, traceID)
    if (not self.enabled) then
        return;
    end

    self:record({
        k = self.Kind.send,
        a = action,
        id = traceID,
        p = PriorityCode[priority or ""] or nil,
        c = ChannelCode[channel or ""] or nil,
        rcp = (channel == "WHISPER") and recipient or nil,
        b = bytes,
        n = self:chunkCount(bytes),
        q = self:ctlSnapshot(),
    });
end

---@param action number|nil
---@param latencyMs number|nil
---@param sent number|nil
---@param textlen number|nil
---@param traceID number|nil
---@return nil
function CommRecorder:recordSent(action, latencyMs, sent, textlen, traceID)
    if (not self.enabled) then
        return;
    end

    local partial = (sent ~= nil and textlen ~= nil and sent < textlen);

    self:record({
        k = self.Kind.sent,
        a = action,
        id = traceID,
        l = latencyMs,
        s = partial and sent or nil,
        t = partial and textlen or nil,
    });
end

---@param action number|nil
---@param bytes number|nil
---@param senderFqn string|nil
---@param traceID number|nil
---@return nil
function CommRecorder:recordReceive(action, bytes, senderFqn, traceID)
    if (not self.enabled) then
        return;
    end

    self:record({
        k = self.Kind.recv,
        a = action,
        id = traceID,
        b = bytes,
        p = 3, -- treat receives as BULK so spam coalesces
        snd = senderFqn,
    });
end

---@param reason number
---@param action number|nil
---@param who string|nil
---@return nil
function CommRecorder:recordDrop(reason, action, who)
    if (not self.enabled) then
        return;
    end

    self:record({
        k = self.Kind.drop,
        x = reason,
        a = action,
        snd = who,
    });
end

local KindLabel = { [1] = "SEND", [2] = "DONE", [3] = "RECV", [4] = "DROP", [5] = "ROLL", [6] = "CONF", [7] = "RESP", };
local PriorityLabel = { [1] = "ALERT", [2] = "NORMAL", [3] = "BULK", };
local ChannelLabel = { [1] = "RAID", [2] = "PARTY", [3] = "WHISPER", [4] = "GUILD", [5] = "INSTANCE", };
local DropLabel = {
    [1] = "decompress-fail",
    [2] = "not-for-me",
    [3] = "tamper",
    [4] = "sender-outdated",
    [5] = "not-backwards-compatible",
    [6] = "missing-action",
    [7] = "missing-id",
    [8] = "confirm-timeout",
    [9] = "unknown-action",
};

--- Human readable duration, e.g. 1h02m03s.
---@param ms number|nil
---@return string
local function formatDuration(ms)
    local seconds = floor((tonumber(ms) or 0) / 1000 + .5);
    local hours = floor(seconds / 3600);
    local minutes = floor((seconds % 3600) / 60);

    if (hours > 0) then
        return ("%sh%02dm%02ds"):format(hours, minutes, seconds % 60);
    end

    if (minutes > 0) then
        return ("%sm%02ds"):format(minutes, seconds % 60);
    end

    return ("%ss"):format(seconds);
end

--- Format a session into copyable text.
---@param Meta table
---@param Traffic table
---@param Entries table
---@param Aggregates table|nil
---@return string
function CommRecorder:formatSession(Meta, Traffic, Entries, Aggregates)
    local ActionsByID = GL:tableFlip(GL.Data.Constants.Comm.Actions or {});
    local Lines = {};

    Meta = Meta or {};
    Traffic = Traffic or {};
    Entries = Entries or {};

    local durationSeconds = (tonumber(Meta.durationMs) or 0) / 1000;

    Lines[#Lines + 1] = ("Gargul comm trace | v%s | started %s | duration %s | group %s"):format(
        tostring(Meta.version or GL.version),
        Meta.startedAt and date("%Y-%m-%d %H:%M:%S", Meta.startedAt) or "?",
        Meta.durationMs and formatDuration(Meta.durationMs) or "?",
        tostring(Meta.groupSize or "?")
    );
    Lines[#Lines + 1] = ("Traffic: Gargul %s msg / %s B | Other addons %s msg / %s B"):format(
        tostring(Traffic.gargul or 0), tostring(Traffic.gargulBytes or 0),
        tostring(Traffic.other or 0), tostring(Traffic.otherBytes or 0)
    );

    -- Traffic sent past ChatThrottleLib. Once this matches MAX_CPS the lib stops
    -- despooling entirely, so anything we queue (any priority) never goes out.
    local Bypass = Traffic.Bypass;
    local bypassBytes = Bypass and Bypass.first and Bypass.last and (Bypass.last - Bypass.first) or nil;
    if (bypassBytes and bypassBytes >= 0 and (Bypass.seconds or 0) > 0) then
        local rate = floor(bypassBytes / Bypass.seconds + .5);
        local maxCPS = Bypass.maxCPS or 800;
        local verdict = "";

        if (rate >= maxCPS) then
            verdict = " | CTL STARVED: queued messages cannot be sent";
        elseif (rate >= maxCPS * .5) then
            verdict = " | heavy, Gargul sends will be slow";
        end

        Lines[#Lines + 1] = ("Sent past ChatThrottleLib: %s B in %ss = %s B/s vs MAX_CPS %s%s"):format(
            bypassBytes, floor(Bypass.seconds + .5), rate, maxCPS, verdict
        );
    end

    if (Traffic.ByPrefix and next(Traffic.ByPrefix)) then
        local Rows = {};
        for prefix, Data in pairs(Traffic.ByPrefix) do
            Rows[#Rows + 1] = { prefix = prefix, count = Data.count or 0, bytes = Data.bytes or 0, };
        end
        table.sort(Rows, function (a, b) return a.bytes > b.bytes; end);

        Lines[#Lines + 1] = "Outgoing addon traffic by prefix (top offenders):";
        for i = 1, math.min(#Rows, 20) do
            local R = Rows[i];
            local rate = durationSeconds > 0 and (" / %s B/s"):format(floor(R.bytes / durationSeconds + .5)) or "";
            Lines[#Lines + 1] = ("  %s: %s msg / %s B%s"):format(R.prefix, R.count, R.bytes, rate);
        end
    end

    if (Aggregates and next(Aggregates)) then
        local Rows = {};
        for _, A in pairs(Aggregates) do
            Rows[#Rows + 1] = A;
        end
        table.sort(Rows, function (a, b) return a.count > b.count; end);

        Lines[#Lines + 1] = "High-frequency actions (aggregated, not listed individually):";
        for _, A in ipairs(Rows) do
            local action = A.a and (ActionsByID[A.a] or ("#" .. tostring(A.a))) or "-";
            local kind = KindLabel[A.k] or tostring(A.k);
            local latInfo = "";
            if (A.latCount and A.latCount > 0) then
                latInfo = (" | lat avg %sms max %sms"):format(math.floor(A.latSum / A.latCount + 0.5), A.latMax or 0);
            end
            Lines[#Lines + 1] = ("  %s %s: %s msg / %s B%s"):format(kind, action, A.count, A.bytes or 0, latInfo);
        end
    end

    Lines[#Lines + 1] = ("Entries: %s"):format(tostring(#Entries));
    Lines[#Lines + 1] = "t(ms) | kind | action | detail";

    for _, E in ipairs(Entries) do
        local action = E.a and (ActionsByID[E.a] or ("#" .. tostring(E.a))) or "-";
        local kind = KindLabel[E.k] or tostring(E.k);
        local Detail = {};

        if (E.id) then Detail[#Detail + 1] = "id=" .. E.id; end
        if (E.p) then Detail[#Detail + 1] = "prio=" .. (PriorityLabel[E.p] or E.p); end
        if (E.c) then Detail[#Detail + 1] = "ch=" .. (ChannelLabel[E.c] or E.c); end
        if (E.rcp) then Detail[#Detail + 1] = "to=" .. E.rcp; end
        if (E.snd) then Detail[#Detail + 1] = "from=" .. E.snd; end
        if (E.b) then Detail[#Detail + 1] = "B=" .. E.b; end
        if (E.n) then Detail[#Detail + 1] = "chunks=" .. E.n; end
        if (E.l) then Detail[#Detail + 1] = "lat=" .. E.l .. "ms"; end
        if (E.s and E.t) then Detail[#Detail + 1] = ("PARTIAL %s/%s"):format(E.s, E.t); end
        if (E.x) then Detail[#Detail + 1] = "reason=" .. (DropLabel[E.x] or E.x); end
        if (E.ev) then Detail[#Detail + 1] = "event=" .. E.ev; end
        if (E.cnt and E.cnt > 1) then Detail[#Detail + 1] = "x" .. E.cnt; end
        if (E.q) then
            Detail[#Detail + 1] = ("ctl[av=%s Qa=%s Qn=%s Qb=%s byp=%s burst=%s cps=%s]"):format(
                E.q.av or "?", E.q.qa or 0, E.q.qn or 0, E.q.qb or 0, E.q.by or 0, E.q.burst or "?", E.q.cps or "?"
            );
        end

        Lines[#Lines + 1] = ("%s | %s | %s | %s"):format(E.o or 0, kind, action, table.concat(Detail, " "));
    end

    return table.concat(Lines, "\n");
end

--- Show the recorded comm trace in a copyable frame. Used by /gl commtrace.
---@param which string|nil "prev" to show the previous (persisted) session
---@return nil
function CommRecorder:export(which)
    if (which == "clear") then
        self:startSession();
        GL:notice(L["Gargul comm trace cleared."]);
        return;
    end

    if (which == "prev") then
        local Prev = GL.DB.CommTrace and GL.DB.CommTrace.Previous;
        if (not Prev or not Prev.Entries) then
            GL:notice(L["No previous Gargul comm trace available."]);
            return;
        end

        GL:frameMessage(self:formatSession(Prev.Meta, Prev.Traffic, Prev.Entries, Prev.Aggregates));
        return;
    end

    if (self.count > 0 or (self.Aggregates and next(self.Aggregates))) then
        self:stampSession();
        GL:frameMessage(self:formatSession(self.Session, self.Traffic, self:orderedEntries(), self.Aggregates));
        return;
    end

    local Store = GL.DB.CommTrace;
    if (Store and Store.Entries and #Store.Entries > 0) then
        GL:frameMessage(self:formatSession(Store.Meta, Store.Traffic, Store.Entries, Store.Aggregates));
        return;
    end

    GL:notice(L["The Gargul comm recorder hasn't captured anything yet. Enable it in Settings > Advanced, reproduce the issue, then try again."]);
end

GL:debug("CommRecorder.lua");
