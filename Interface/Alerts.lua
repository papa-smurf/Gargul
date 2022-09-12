
--- Necessary workaround to make sure alerts use a non-secure mixin. Will otherwise freeze UI in ERA/TBC
Gargul_ContainedAlertFrameMixin = {};
Gargul_ContainedAlertFrameMixin.OnPostShow = ContainedAlertFrameMixin.OnPostShow;
Gargul_ContainedAlertFrameMixin.OnPostHide = ContainedAlertFrameMixin.OnPostHide;
Gargul_ContainedAlertFrameMixin.SetAlertContainer = ContainedAlertFrameMixin.SetAlertContainer;
Gargul_ContainedAlertFrameMixin.GetAlertContainer = ContainedAlertFrameMixin.GetAlertContainer;
Gargul_ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged = ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged;
Gargul_ContainedAlertFrameMixin.ManagesOwnOutroAnimation = ContainedAlertFrameMixin.ManagesOwnOutroAnimation;
Gargul_ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation = ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation;

---@type GL
local _, GL = ...;

---@class AlertInterface
GL.Interface.Alerts = {
    _initialized = false,
};

local Alerts = GL.Interface.Alerts;

function Alerts:_init()
    GL:debug("Interface/Alerts:_init");

    if (self._initialized) then
        return;
    end

    local Types = {
        SoftRes = AlertFrame:AddQueuedAlertFrameSubSystem("GargulSoftres", function (self, message)
            self.Message:SetText(message);
        end, 6, math.huge),
        Item = AlertFrame:AddQueuedAlertFrameSubSystem("GargulSoftres", function (self, message)
            self.Message:SetText(message);
        end, 6, math.huge),
    }

    ---@todo: /script _G.gargultest();
    GL.Events:register("AlertsSoftresImported", "GL.SOFTRES_IMPORTED", function ()
        AlertFrame:AddQueuedAlertFrameSubSystem("DKPReceivedAlertFrameTemplate", DKPReceivedAlertFrame_SetUp, 6, math.huge)
        Types.SoftRes:AddAlert("Import successful!");
    end);
end