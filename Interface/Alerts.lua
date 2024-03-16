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
    Types = {
        GargulNotification = AlertFrame:AddQueuedAlertFrameSubSystem("GargulNotification", function (self, Details)
            -- Override the defaults with whatever the user wants to show
            Details = GL:tableMerge({
                message = "",
                icon = "Interface/AddOns/Gargul/Assets/Icons/gargul",
                hex = "",
            }, Details);
            local Alert = self;

            Alert.Icon:SetTexture(Details.icon);
            Alert.Message:SetText(Details.message);

            if (type(Details.onClick) == "function") then
                Alert:SetScript("OnClick", function ()
                    Details.onClick();
                    Alert:Hide();
                end);
            end
        end, 6, math.huge),

        Item = AlertFrame:AddQueuedAlertFrameSubSystem("GargulItem", function (self, itemID, title, message)
            local Alert = self;

            GL:onItemLoadDo(itemID, function (Details)
                local longestLength = math.max(string.len(Details.name), string.len(message));
                title = title or Details.link;

                Alert.Label:SetText(title);

                Alert.Icon:SetTexture(Details.icon);
                Alert.Message:SetText(message);

                Alert:SetScript("OnEnter", function()
                    GameTooltip:SetOwner(Alert, "ANCHOR_TOP");
                    GameTooltip:SetHyperlink(Details.link);
                    GameTooltip:Show();
                end);

                Alert:SetScript("OnLeave", function()
                    GameTooltip:Hide();
                end);

                Alert:SetWidth(Alert:GetWidth() + (longestLength * 3));
            end);
        end, 6, math.huge),
    },
};

local Alerts = GL.Interface.Alerts;

function Alerts:fire(frameType, ...)
    if (self.Types[frameType]) then
        self.Types[frameType]:AddAlert(...);
        return true;
    end

    return true;
end
