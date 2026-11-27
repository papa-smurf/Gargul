local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.Interface.GargulMasterLoot = GL.Interface.GargulMasterLoot or {};

--- The dialog every player gets when someone wants to start Gargul Master Loot
---@class GargulMasterLootOptInDialog
local OptIn = {
    Dialogs = {},
};

GL.Interface.GargulMasterLoot.OptIn = OptIn; ---@type GargulMasterLootOptInDialog

--- Ask the player to opt in
---
---@param Request table { sessionID, masterLooter }
---@param callback fun(accepted: boolean)
---@return nil
function OptIn:show(Request, callback)
    local sessionID = Request.sessionID;
    local dialogType = "GML_OPTIN_" .. tostring(sessionID);

    local answered = false;
    local answer = function (accepted)
        if (answered) then
            return;
        end

        answered = true;

        local Answered = self.Dialogs[sessionID];
        self.Dialogs[sessionID] = nil;

        -- StaticPopup still needs the definition while it hides after the click
        if (Answered) then
            GL:after(1, "GML.OptIn.Unregister." .. tostring(sessionID), function ()
                Answered:unregister();
            end);
        end

        callback(accepted);
    end;

    local masterLooter = tostring(Request.masterLooter or "?");
    local Dialog = GL.Dialog.new(dialogType)
        :setMessage((L["|c00%sGargul Master Loot|r\n\n%s wants to master loot via group loot.\n\nIf you accept, Gargul passes on tradable loot for you automatically and %s is warned whenever that stops working. There is no way to switch it off while it's active, other than leaving the group.\n\nDo you accept?"]):format(
            GL.Data.Constants.addonHexColor,
            masterLooter,
            masterLooter
        ))
        :setCloseOnEscape(false)
        :setPaddingTop(1)
        :setButtons({
            { label = L["Accept"], onClick = function () answer(true); end, },
            { label = L["Decline"], onClick = function () answer(false); end, },
        });

    self.Dialogs[sessionID] = Dialog;
    Dialog:show();
end

--- Close the dialog of a session (e.g. because the ML gave up on it)
---
---@param sessionID string|nil
---@return nil
function OptIn:hide(sessionID)
    if (not sessionID or not self.Dialogs[sessionID]) then
        return;
    end

    self.Dialogs[sessionID]:hide();
    self.Dialogs[sessionID]:unregister();
    self.Dialogs[sessionID] = nil;
end
