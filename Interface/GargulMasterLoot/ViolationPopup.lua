local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.Interface.GargulMasterLoot = GL.Interface.GargulMasterLoot or {};

--[[ CONSTANTS ]]
local MAXIMUM_VISIBLE_LINES = 8;
local DIALOG_TYPE = "GML_VIOLATION";
local WARNING_COLOR = "F7922E";

--- The (intrusive) popup the master looter gets whenever a player deviates
---@class GargulMasterLootViolationPopup
---@field Violations table
---@field Dialog Dialog|nil
local ViolationPopup = {
    Violations = {},
    Dialog = nil,
};

GL.Interface.GargulMasterLoot.ViolationPopup = ViolationPopup; ---@type GargulMasterLootViolationPopup

--- Raise a violation: print it, make noise and show it until acknowledged
---
---@param Violation table { name, kind, reason, itemLink? }
---@return nil
function ViolationPopup:report(Violation)
    table.insert(self.Violations, Violation);

    GL:warning((L["Gargul Master Loot: %s %s%s"]):format(
        tostring(Violation.name),
        tostring(Violation.reason),
        Violation.itemLink and (" - " .. Violation.itemLink) or ""
    ));

    -- This is a tamper alert, it's loud on purpose and ignores the "no sounds" setting
    pcall(PlaySound, (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959, "Master");

    self:show();
end

---@return string
function ViolationPopup:buildMessage()
    local Lines = {
        ("|c00%s%s|r\n"):format(WARNING_COLOR, L["Gargul Master Loot warning"]),
    };

    local total = #self.Violations;
    local first = math.max(1, total - MAXIMUM_VISIBLE_LINES + 1);

    for index = first, total do
        local Violation = self.Violations[index];

        table.insert(Lines, ("%s %s%s"):format(
            tostring(Violation.name),
            tostring(Violation.reason),
            Violation.itemLink and (" - " .. Violation.itemLink) or ""
        ));
    end

    if (first > 1) then
        table.insert(Lines, (L["... and %d earlier warnings"]):format(first - 1));
    end

    return table.concat(Lines, "\n");
end

--- (Re)show the popup with every unacknowledged violation
---
---@return nil
function ViolationPopup:show()
    -- StaticPopups don't update their text while visible, so we replace it
    if (self.Dialog) then
        self.Dialog:hide();
    end

    self.Dialog = GL.Dialog.new(DIALOG_TYPE)
        :setMessage((self:buildMessage():gsub("%%", " percent ")))
        :setCloseOnEscape(false)
        :setIsAlert(true)
        :setPaddingTop(0)
        :setButtons({
            { label = L["Acknowledge"], onClick = function () self.Violations = {}; end, },
        });

    self.Dialog:show();
end
