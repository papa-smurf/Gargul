local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class ItemDataManager
---@field _initialized boolean
---@field _progressCallbacks table
local ItemDataManager = {
    _initialized = false,
    _progressCallbacks = {},
};
GL.ItemDataManager = ItemDataManager;

--- Check if Gargul_ItemData addon is loaded
---
---@return boolean
function ItemDataManager:isLoaded()
    return _G.Gargul_ItemData ~= nil;
end

--- Check if Gargul_ItemData addon is enabled
---
---@return boolean
function ItemDataManager:isEnabled()
    local name = "Gargul_ItemData";

    local addonName, title, notes, loadable, reason = GL.GetAddOnInfo(name);
    if (not addonName) then
        return false;
    end

    -- For LoadOnDemand addons, if loadable is true or reason is "DEMAND_LOADED", it's available
    if (loadable or reason == "DEMAND_LOADED") then
        return true;
    end

    -- Otherwise check enable state
    local enableState = GL.GetAddOnEnableState(GL.User.name, name);
    return enableState == 2;
end

--- Enable Gargul_ItemData addon
---
---@return boolean success
function ItemDataManager:enable()
    if (C_AddOns and C_AddOns.EnableAddOn) then
        -- Retail: enable for this character
        C_AddOns.EnableAddOn("Gargul_ItemData", GL.User.name);
    elseif (EnableAddOn) then
        -- Classic: enable for this character
        EnableAddOn("Gargul_ItemData", GL.User.name);
    else
        return false;
    end
    
    return true;
end

--- Register a progress callback for item population
---
---@param callback function Called with (progress: number 0-100, done: boolean|nil)
---@return nil
function ItemDataManager:onProgress(callback)
    tinsert(self._progressCallbacks, callback);
end

--- Unregister a previously registered progress callback
---
---@param callback function The same reference passed to onProgress
---@return nil
function ItemDataManager:offProgress(callback)
    for i = #self._progressCallbacks, 1, -1 do
        if (self._progressCallbacks[i] == callback) then
            table.remove(self._progressCallbacks, i);
        end
    end
end

--- Broadcast progress to all registered listeners
--- Called by Gargul_ItemData (bootstrap) during population
---
---@param progress number 0-100
---@param done boolean|nil Whether population is complete
---@return nil
function ItemDataManager:_fireProgress(progress, done)
    for _, callback in ipairs(self._progressCallbacks) do
        pcall(callback, progress, done);
    end
end

--- Load Gargul_ItemData addon if it's enabled but not loaded
---
---@return boolean success
function ItemDataManager:load()
    if (self:isLoaded()) then
        return true;
    end

    local LoadAddOn = LoadAddOn or (C_AddOns and C_AddOns.LoadAddOn);
    if (not LoadAddOn) then
        return false;
    end

    local loaded, reason = LoadAddOn("Gargul_ItemData");
    if (not loaded) then
        GL:warning(("Failed to load Gargul_ItemData: %s"):format(tostring(reason)));
        return false;
    end

    return true;
end

--- Prompt user to enable and populate item search data
---
---@return nil
function ItemDataManager:promptSetup()
    local needsEnable = not self:isEnabled();
    local needsReload = needsEnable;

    GL.Dialog("ItemDataSetup")
        :setMessage("Enable item search?\n\nThis lets you search for items by name in the Auto Roll rules. The first scan takes a few minutes while item data is downloaded. You can keep playing normally during this process, as it will be paused during combat.")
        :setButtons({
            {
                label = needsReload and "Enable & Reload" or "Start Scan",
                onClick = function ()
                    if (needsEnable) then
                        self:enable();
                        GL.ReloadUI();
                        return;
                    end

                    -- Already enabled, just load and populate
                    local wasLoaded = self:isLoaded();
                    if (not wasLoaded) then
                        self:load();
                    end

                    local nowLoaded = self:isLoaded();
                    if (nowLoaded) then
                        local ItemData = _G.Gargul_ItemData;
                        -- Always re-init to pick up any external DB reset
                        ItemData:_init();
                        ItemData:populate();
                    end
                end,
            },
            {
                label = "No Thanks",
            },
        })
        :setCloseOnEscape(true)
        :show();
end

--- Start populating Gargul_ItemData with item links
---
---@return nil
function ItemDataManager:populate()
    if (not self:isLoaded()) then
        GL:warning(L["Gargul_ItemData is not loaded."]);
        return;
    end

    GL:success(L["Starting item data population. This may take a while..."]);
    _G.Gargul_ItemData:populate();
end

--- Stop populating item data
---
---@return nil
function ItemDataManager:stopPopulate()
    if (not self:isLoaded()) then
        return;
    end

    _G.Gargul_ItemData:stopPopulate();
end

--- Search for items (async - results delivered via callback)
---
---@param query string
---@param maxResults number|nil
---@param callback function Called with (results)
---@return nil
function ItemDataManager:search(query, maxResults, callback)
    callback = callback or function () end;

    if (not self:isLoaded()) then
        callback({});
        return;
    end

    _G.Gargul_ItemData:search(query, maxResults, callback);
end

--- Get the number of cached items
---
---@return number
function ItemDataManager:countItems()
    if (not self:isLoaded()) then
        return 0;
    end

    return _G.Gargul_ItemData:countItems();
end

--- Initialize the ItemDataManager
---
---@return nil
function ItemDataManager:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- If the addon is enabled, load it and check if population needs to resume
    if (not self:isLoaded() and self:isEnabled()) then
        self:load();
    end

    if (self:isLoaded()) then
        -- Check the SavedVariable global directly (ADDON_LOADED for the LoD addon
        -- may be queued so ItemData.DB might not be set yet)
        local db = type(GargulItemDataDB) == "table" and GargulItemDataDB;
        if (not db) then
            return;
        end

        local shouldPopulate = db.Populating;

        -- New interface version detected: auto-populate to pick up new items
        local currentVersion = select(4, GetBuildInfo());
        if (db.InterfaceVersion and db.InterfaceVersion ~= currentVersion) then
            db.InterfaceVersion = currentVersion;
            shouldPopulate = true;
        end

        if (shouldPopulate) then
            GL:after(10, "ItemDataManagerAutoResume", function ()
                local ItemData = _G.Gargul_ItemData;
                if (ItemData and not ItemData._populating) then
                    if (not ItemData.DB) then
                        ItemData:_init();
                    end
                    ItemData:populate();
                end
            end);
        end
    end
end
