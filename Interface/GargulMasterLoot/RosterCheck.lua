local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.Interface.GargulMasterLoot = GL.Interface.GargulMasterLoot or {};

--[[ CONSTANTS ]]
local DIALOG_TYPE = "GML_ROSTER_CHECK";
local MAXIMUM_VISIBLE_PLAYERS = 10;

local StatusLabels = {
    waiting = L["has not responded (no Gargul, or too old a version?)"],
    prompted = L["has not answered the dialog yet"],
    declined = L["declined"],
    outdated = L["has a Gargul version that's too old"],
    offline = L["is offline"],
};

--- Shown to the master looter when not everyone is ready to start Gargul Master Loot
--- The master looter can remove those players, try again or cancel
---@class GargulMasterLootRosterCheck
local RosterCheck = {
    Dialog = nil,
};

GL.Interface.GargulMasterLoot.RosterCheck = RosterCheck; ---@type GargulMasterLootRosterCheck

--- Show the players that aren't ready
---
---@param NotReady table Member entries
---@param Handlers table { remove: function, retry: function, cancel: function }
---@return nil
function RosterCheck:show(NotReady, Handlers)
    local Lines = {
        ("|c00%s%s|r\n"):format(GL.Data.Constants.addonHexColor, L["Gargul Master Loot"]),
        L["These players are not ready:"],
        "",
    };

    for index, Entry in ipairs(NotReady) do
        if (index > MAXIMUM_VISIBLE_PLAYERS) then
            table.insert(Lines, (L["... and %d more"]):format(#NotReady - MAXIMUM_VISIBLE_PLAYERS));
            break;
        end

        local status = Entry.online == false and "offline" or Entry.status;
        table.insert(Lines, ("%s %s"):format(tostring(Entry.name), StatusLabels[status] or tostring(status)));
    end

    if (self.Dialog) then
        self.Dialog:hide();
    end

    self.Dialog = GL.Dialog.new(DIALOG_TYPE)
        :setMessage((table.concat(Lines, "\n"):gsub("%%", " percent ")))
        :setCloseOnEscape(false)
        :setPaddingTop(0)
        :setButtons({
            { label = L["Remove them"], onClick = Handlers.remove, },
            { label = L["Check again"], onClick = Handlers.retry, },
            { label = L["Cancel"], onClick = Handlers.cancel, },
        });

    self.Dialog:show();
end

---@return nil
function RosterCheck:hide()
    if (self.Dialog) then
        self.Dialog:hide();
        self.Dialog = nil;
    end
end
