
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

---@class Alerts
GL.Alerts = {
    _initialized = false,

    Types = {
        ItemAwarded = AlertFrame:AddQueuedAlertFrameSubSystem("LootWonAlertFrameTemplate", function (self, itemLink)
            _G.LootWonAlertFrame_SetUp(self, itemLink);
        end, 6, math.huge),

        SoftRes = AlertFrame:AddQueuedAlertFrameSubSystem("GargulSoftres", function (self, message)
            self.Message:SetText(message);
        end, 6, math.huge),
    }
};

local Alerts = GL.Alerts;

function Alerts:init()
    GL:debug("Alerts:_init");

    if (self._initialized) then
        return;
    end

    local Types = {
        Item = AlertFrame:AddQueuedAlertFrameSubSystem("GargulItem", function (self, itemID, title, message)
            local Alert = self;

            GL:onItemLoadDo(itemID, function (Items)
                local longestLength = math.max(string.len(Items[1].name), string.len(message));
                title = title or Items[1].link;

                Alert.Label:SetText(title);

                Alert.Icon:SetTexture(Items[1].icon);
                Alert.Message:SetText(message);

                Alert:SetScript("OnEnter", function()
                    GameTooltip:SetOwner(Alert, "ANCHOR_TOP");
                    GameTooltip:SetHyperlink(Items[1].link);
                    GameTooltip:Show();
                end);

                Alert:SetScript("OnLeave", function()
                    GameTooltip:Hide();
                end);

                Alert:SetWidth(Alert:GetWidth() + (longestLength * 3));
            end);
        end, 6, math.huge),
    };

    ---@todo: /script _G.gargultest();
    _G.gargultest = function ()
        --GL:onItemLoadDo(18608, function (Items)
        GL:onItemLoadDo(31986, function (Items)
            local Benediction = Items[1];
            local LootAlertSystem = AlertFrame:AddQueuedAlertFrameSubSystem("LootWonAlertFrameTemplate", _G.LootWonAlertFrame_SetUp, 6, math.huge);
            LootAlertSystem:AddAlert(Benediction.link);
        end);
    end;



    Types.Item:AddAlert(31986, nil, "Awarded to: " .. "|c00FFFFFFZhoraxasdasa|r");
end

function Alerts:fire(frameType, ...)
    -- Old version of WoW use a secure mixin for alerts, making it completely unusable with native alert frames
    if (not self.Types.frameType
        and GL.clientVersion < 30000
    ) then
        return false;
    end

    if (self.Types.frameType) then
        self.Types[frameType]:AddAlert(...);
        return true;
    end

    return true;
end