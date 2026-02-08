---@type GL
local _, GL = ...;

local L = Gargul_L;

local gaveNoAssistWarning = false;

---@return nil
function GL:message(...)
    print("|TInterface/TARGETINGFRAME/UI-RaidTargetingIcon_3:12|t|cff8aecff Gargul : |r" .. table.concat({ ... }, " "));
end

--- Print a colored message
---
---@param color string
---@vararg string
---@return nil
function GL:coloredMessage(color, ...)
    GL:message(("|c00%s%s"):format(color, string.join(" ", ...)));
end

--- Print a multicolored message
--- ColoredMessages is table of tables, with the message
--- being in the first and the color being in the second position
--- e.g. GL:multiColoredMessage({{"message", "color"},{"message2", "color2"}});
---
---@vararg table
---@param delimiter string
---@return nil
function GL:multiColoredMessage(ColoredMessages, delimiter)
    local multiColoredMessage = "";
    delimiter = delimiter or " ";

    local firstMessage = true;
    for _, Envelope in pairs(ColoredMessages) do
        local message = Envelope[1];
        local color = Envelope[2];

        if (message and type(message) == "string"
            and color and type(color) == "string"
        ) then
            local coloredMessage = ("|c00%s%s|r"):format(color, message);

            if (firstMessage) then
                multiColoredMessage = coloredMessage;
            else
                multiColoredMessage = ("%s%s%s"):format(multiColoredMessage, delimiter, coloredMessage);
            end

            firstMessage = false;
        end
    end

    GL:message(multiColoredMessage);
end

--- Print a success message (green)
---
---@return nil
function GL:success(...)
    GL:coloredMessage("92FF00", ...);
end

--- Print a debug message (orange)
---
---@return nil
function GL:debug(...)
    if (not GL.Settings
        or not GL.Settings.Active
        or GL.Settings.Active.debugModeEnabled ~= true
    ) then
        return;
    end

    GL:coloredMessage("F7922E", ...);
end

--- Print a notice message (yellow)
---
---@return nil
function GL:notice(...)
    GL:coloredMessage("FFF569", ...);
end

--- Print a warning message (orange)
---
---@return nil
function GL:warning(...)
    GL:coloredMessage("F7922E", ...);
end

--- Dump mixed to plain text lines for xd buffer
---@param mixed any
---@param depth number
---@param seen table
---@param lines table
---@return nil
local function xdDumpToBuffer(mixed, depth, seen, lines)
    depth = depth or 0;
    seen = seen or {};
    lines = lines or {};
    local indent = strrep("  ", depth);
    local t = type(mixed);

    if (t ~= "table") then
        table.insert(lines, indent .. tostring(mixed));
        return;
    end
    if (seen[mixed]) then
        table.insert(lines, indent .. "<cycle>");
        return;
    end
    seen[mixed] = true;
    for k, v in pairs(mixed) do
        local keyStr = type(k) == "string" and k:match("^[%w_]+$") and k or ("[" .. tostring(k) .. "]");
        if (type(v) == "table" and not seen[v]) then
            table.insert(lines, indent .. keyStr .. "={");
            xdDumpToBuffer(v, depth + 1, seen, lines);
            table.insert(lines, indent .. "}");
        else
            table.insert(lines, indent .. keyStr .. "=" .. tostring(v));
        end
    end
end

--- Print a debug message (bright red)
--- We use a separate method for this to make searching for, and cleaning up debug dumps, easier
--- Output is also appended to GL.XDOutputBuffer for /gl xda.
---
---@return nil
function GL:xd(mixed)
    local header = ("\n|c00967FD2%s|r ================"):format(date('%H:%M:%S'));

    print(header);
    DevTools_Dump(mixed);

    GL.XDOutputBuffer = GL.XDOutputBuffer or {};
    table.insert(GL.XDOutputBuffer, (header:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")));
    local lines = {};
    xdDumpToBuffer(mixed, 0, {}, lines);
    for _, line in ipairs(lines) do
        table.insert(GL.XDOutputBuffer, line);
    end
end

--- Show xd output buffer in a frame (selectable, copyable). Use /gl xda after GL:xd() calls.
---
---@return nil
function GL:xda()
    if (not GL.XDOutputBuffer or #GL.XDOutputBuffer == 0) then
        GL:notice("xd buffer is empty. Run GL:xd() first.");
        return;
    end
    GL:frameMessage(table.concat(GL.XDOutputBuffer, "\n"));
end

--- Print a error message (red)
---
---@return nil
function GL:error(...)
    GL:coloredMessage("BE3333", ...);
end

---@param text string
---@return nil
function GL:popupMessage(text)
    GL:debug("GL:popupMessage");

    local frameName = "Gargul.popupMessage";
    local Window = _G[frameName];

    if (not Window) then
        ---@type Frame
        Window = GL.Interface:createWindow{
            name = frameName,
            hideMinimizeButton = true,
            hideResizeButton = true,
            hideWatermark = true,
        };

        Window.Text = GL.Interface:createFontString(Window);
        Window.Text:SetFont(1.25, "OUTLINE");
        Window.Text:SetJustifyH("CENTER");
        Window.Text:SetPoint("CENTER", Window, "CENTER");
        Window.Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 60);

        Window.DiscordURL = GL.Interface:inputBox(Window);
        Window.DiscordURL:SetFont(1.25, "");
        Window.DiscordURL:SetPoint("CENTER", Window, "CENTER");
        Window.DiscordURL:SetPoint("BOTTOM", Window, "BOTTOM", 0, 40);
        Window.DiscordURL:SetWidth(186);

        _G[frameName] = Window;
        GL.Interface:makeCloseableWithEscape(Window);
    end

    Window.DiscordURL:SetText(GL.Data.Constants.discordURL);
    text = ("%s\n|c00FFF569%s|r"):format(text, L["Need more help?"]);
    Window.Text:SetText(text);

    -- Fit the window to its contents
    local textWidth, textHeight = Window.Text:GetUnboundedStringWidth(), Window.Text:GetStringHeight();
    Window:SetWidth(math.max(250, textWidth + 40));
    Window:SetHeight(textHeight + 100);

    Window:Show();

    -- This is to make sure the tutorial window is always on top of what we're calling it from
    Window:StartMoving();
    Window:StopMovingOrSizing();
end

---@param message string
---@return nil
function GL:frameMessage(message)
    if (type(message) == "table") then
        message = GL.JSON:encode(message);
    end

    local AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Fill");
    Window:SetStatusTable({ width = 600, height = 450, });
    Window:SetCallback("OnClose", function()
        AceGUI:Release(Window);
    end);

    local EditBox = AceGUI:Create("MultiLineEditBox");
    EditBox:SetLabel("");
    EditBox:DisableButton(true);
    EditBox:SetNumLines(math.max(20, math.ceil(#message / 80)));
    EditBox:SetMaxLetters(0);
    EditBox:SetText(message);

    Window:AddChild(EditBox);

    EditBox:SetFocus();
    if (#message < 10000) then
        EditBox:HighlightText();
    end
end

---@param message string
---@param chatType string
---@param language? string
---@param channel? string
---@param stw? boolean
---@param pretend? boolean
---@return string|nil
function GL:sendChatMessage(message, chatType, language, channel, stw, pretend)
    stw = stw ~= false;

    -- No point sending an empty message!
    if (GL:empty(message)) then
        return;
    end

    -- No point sending an empty message!
    if (GL:empty(chatType)) then
        GL:warning("Missing 'chatType' in GL:sendChatMessage!");
        return;
    end

    -- The user is not in a group of any kind but still wants to
    -- post a message on group or raid. Let's assume he's testing stuff
    if (not GL.User.isInGroup
        and GL:inTable({ "GROUP", "PARTY", "RAID", "RAID_WARNING", }, chatType)
    ) then
        -- We never want to show this message, not even whilst solo
        if (GL.isMuted) then
            return;
        end

        return GL:coloredMessage("FF7D0A", message); -- FF7D0A is the same color as /ra text
    end

    if (stw) then
        message = ("{rt3} %s : %s"):format(GL.name, message);
    end

    -- The player wants to message the group (either raid or party)
    if (chatType == "GROUP") then
        chatType = "PARTY";

        if (GL.User.isInRaid) then
            chatType = "RAID";
        end

    -- The player wants to post in RAID_WARNING but is either not in a raid or doesn't have assist
    elseif (chatType == "RAID_WARNING") then
        if (not GL.User.isInRaid) then
            chatType = "PARTY";
        elseif (not GL.User.hasAssist) then
            if (not gaveNoAssistWarning) then
                GL:warning("You need assist to use raid warnings!");
                gaveNoAssistWarning = true;
            end

            chatType = "RAID";
        end
    elseif (chatType == "CURRENT") then
        chatType = DEFAULT_CHAT_FRAME.editBox:GetAttribute("chatType");
        channel = DEFAULT_CHAT_FRAME.editBox:GetAttribute("tellTarget");

        if (not GL:inTable({ "BN_WHISPER", "CHANNEL", "WHISPER", }, chatType)) then
            channel = nil;
        end
    end

    if (not pretend) then
        SendChatMessage(
            message,
            chatType,
            language,
            channel
        );
    end

    return message;
end

--- Temporarily mute the add-on by not showing any messages
---
---@return nil
function GL:mute()
    GL.isMuted = true;
end

--- Unmute add-on after (temporary) mute
---
---@return nil
function GL:unmute()
    GL.isMuted = false;
end
