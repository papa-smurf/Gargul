---@type GL
local _, GL = ...;

-- AddOns
GL.GetAddOnEnableState = GetAddOnEnableState or C_AddOns.GetAddOnEnableState;
GL.GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo;
GL.GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata;
GL.GetNumAddOns = GetNumAddons or C_AddOns.GetNumAddOns;
GL.IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded;

-- Container
GL.getContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
