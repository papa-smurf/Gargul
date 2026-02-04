---@type GL
local _, GL = ...;

-- AddOns
GL.GetAddOnEnableState = GetAddOnEnableState or C_AddOns.GetAddOnEnableState;
GL.GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo;
GL.GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata;
GL.GetNumAddOns = GetNumAddOns or C_AddOns.GetNumAddOns;
GL.IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded;

-- Container
GL.GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
GL.UseContainerItem = UseContainerItem or C_Container.UseContainerItem;

-- CurrencyInfo
GL.GetCoinTextureString = GetCoinTextureString or C_CurrencyInfo.GetCoinTextureString;

-- Item
GL.GetItemInfo = GetItemInfo or C_Item.GetItemInfo;
GL.GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant;

-- PartyInfo
GL.InviteUnit = InviteUnit or C_PartyInfo.InviteUnit;

-- UI reload: C_UI.Reload exists from 1.13.2+, ReloadUI is legacy alias
GL.ReloadUI = C_UI and C_UI.Reload or ReloadUI;

---@param method string
---@param player? string
---@param threshold? string
---
---@test /script _G.Gargul.SetLootMethod("master", _G.Gargul.User.name, "common");
GL.SetLootMethod = function(method, player, threshold)
    if (not GL.User.isInGroup) then
        return print(ERR_NOT_IN_GROUP);
    end

    local Methods = {
        freeforall = 0,
        roundrobin = 1,
        master = 2,
        group = 3,
        needbeforegreed = 4,
        personalloot = 5,
    };

    local eventID = "SetLootMethodLootMethodChangedListener";
    GL.Events:unregister(eventID);

    local unregisterEventTimer = "SetLootMethodUnregisterEvent";
    local delayedSetThresholdTimer = "SetLootMethodSetThresholdDelay";
    GL:cancelTimer{ unregisterEventTimer, delayedSetThresholdTimer };

    if (UnitAffectingCombat("player")) then
        return GL:afterCombatDo(GL.SetLootMethod(method, player, threshold));
    end

    if (threshold) then
        local skipSetLootMethod = (function ()
            local currentLootMethod = GL.GetLootMethod();
            if (currentLootMethod == method
                or currentLootMethod == Methods[method]
            ) then
                GL.SetLootThreshold(threshold);
                return true;
            end

            GL.Events:register(eventID, "PARTY_LOOT_METHOD_CHANGED", function ()
                GL.Events:unregister(eventID);

                GL:after(.5, delayedSetThresholdTimer, function()
                    GL.SetLootThreshold(threshold);
                end);
            end);

            GL:after(1, unregisterEventTimer, function ()
                GL.Events:unregister(eventID);
            end);

            return false;
        end)();

        if (skipSetLootMethod) then
            return;
        end
    end

    if (_G.SetLootMethod) then
        return SetLootMethod(method, player);
    end

    C_PartyInfo.SetLootMethod(Methods[method], player);
end;

---@param threshold string
---@param retry? boolean
---
---@test /script _G.Gargul.SetLootThreshold("legendary");
GL.SetLootThreshold = function(threshold, retry)
    local eventID = "SetLootThresholdLootMethodChangedListener";
    GL.Events:unregister(eventID);

    local getThresholdtimerID = "GetLootThresholdRetryTimer";
    local setThresholdtimerID = "SetLootThresholdRetryTimer";
    GL:cancelTimer{ getThresholdtimerID, setThresholdtimerID };

    local Thresholds = {
        poor = 0,
        common = 1,
        uncommon = 2,
        rare = 3,
        epic = 4,
        legendary = 5,
        artifact = 6,
        heirloom = 7,
        wowtoken = 8,
    };

    if (not retry) then
        GL.Events:register(eventID, "PARTY_LOOT_METHOD_CHANGED", function ()
            GL:cancelTimer(setThresholdtimerID);

            if (GetLootThreshold() ~= threshold) then
                retry = true;
                GL.SetLootThreshold(threshold, retry);
            end
        end);

        retry = true;
        GL:after(.5, setThresholdtimerID, function ()
            GL.SetLootThreshold(threshold, retry);
        end);
    else
        GL:after(.5, getThresholdtimerID, function ()
            if (GetLootThreshold() ~= Thresholds[threshold]) then
                GL:error(("Unable to set loot threshold to %s"):format(threshold));
            end
        end);
    end

    local method = SetLootThreshold and SetLootThreshold or C_PartyInfo.SetLootThreshold;
    method(Thresholds[threshold]);
end

--- More reboust, client-agnostic implementation which always includes a raid index for ease of use
---
---@test /dump _G.Gargul.GetLootMethod();
---
--- Only when loot master is enabled
---@test /dump GetRaidRosterInfo(select(2, _G.Gargul.GetLootMethod()));
GL.GetLootMethod = function ()
    local method, masterLootPartyID, masterLooterRaidID;

    if (GL.User.isMasterLooter) then
        return "master", GL.User.raidIndex;
    end

    if (GetLootMethod) then
        method, masterLootPartyID, masterLooterRaidID = GetLootMethod();
    else
        local Methods = {
            [0] = "freeforall",
            [1] = "roundrobin",
            [2] = "master",
            [3] = "group",
            [4] = "needbeforegreed",
            [5] = "personalloot",
        };

        method, masterLootPartyID, masterLooterRaidID = C_PartyInfo.GetLootMethod();
        method = Methods[method];
    end

    local masterLooterIndex = masterLootPartyID or masterLooterRaidID;

    if (method ~= "master") then
        return method;
    end

    if (GL.User.isInRaid) then
        return method, masterLooterIndex;
    end

    for index = 1, _G.MEMBERS_PER_RAID_GROUP do
        local isMasterLooter = select(11, GetRaidRosterInfo(index));

        if (isMasterLooter) then
            return method, index;
        end
    end
end;
