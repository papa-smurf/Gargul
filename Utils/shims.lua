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
GL.GetLootMethod = GetLootMethod or function ()
    local Methods = {
        [0] = "freeforall",
        [1] = "roundrobin",
        [2] = "master",
        [3] = "group",
        [4] = "needbeforegreed",
        [5] = "personalloot",
    };

    return Methods[C_PartyInfo.GetLootMethod()];
end;