---@type GL
local _, GL = ...;

-- Enum
--- This enum does not yet exist in classic era
Enum.LootMethod = Enum.LootMethod or {
    Freeforall = 0,
    Roundrobin = 1,
    Masterlooter = 2,
    Group = 3,
    Needbeforegreed = 4,
    Personal = 5,
};

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

--- More reboust, client-agnostic implementation which always includes a raid index for ease of use
---
---@test /dump _G.Gargul.GetLootMethod();
---
--- Only when loot master is enabled
---@test /dump GetRaidRosterInfo(select(2, _G.Gargul.GetLootMethod()));
GL.GetLootMethod = function ()
    local method, masterLootPartyID, masterLooterRaidID;
    if (GetLootMethod) then
        local Methods = {
            ["freeforall"] = 0,
            ["roundrobin"] = 1,
            ["master"] = 2,
            ["group"] = 3,
            ["needbeforegreed"] = 4,
            ["personalloot"] = 5,
        };

        method, masterLootPartyID, masterLooterRaidID = GetLootMethod();
        method = Methods[method];
    else
        method, masterLootPartyID, masterLooterRaidID = C_PartyInfo.GetLootMethod();
    end

    local masterLooterIndex = masterLootPartyID or masterLooterRaidID;

    if (method ~= Enum.LootMethod.Masterlooter) then
        return method;
    end

    if (GL.User.isInRaid) then
        return method, masterLooterIndex;
    end

    -- GetLootMethod will return 0 when we're in a group ( not raid ), and we ourselves are the loot master
    if (masterLooterIndex == 0) then
        return method, GL.User.raidIndex;
    end

    for index = 1, _G.MEMBERS_PER_RAID_GROUP do
        local isMasterLooter = select(11, GetRaidRosterInfo(index));

        if (isMasterLooter) then
            return method, index;
        end
    end
end;