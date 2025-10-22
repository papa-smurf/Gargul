---@type GL
local _, GL = ...;

-- AddOns
GL.GetAddOnEnableState = GetAddOnEnableState or C_AddOns.GetAddOnEnableState;
GL.GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo;
GL.GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata;
GL.GetNumAddOns = GetNumAddons or C_AddOns.GetNumAddOns;
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
GL.SetLootMethod = SetLootMethod or C_PartyInfo.SetLootMethod;

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
