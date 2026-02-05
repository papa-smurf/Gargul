local L = Gargul_L;

---@type GL
local _, GL = ...;

--- Reusable profiles module for namespaced settings (e.g. AutoRoll, PackMule).
--- Profiles are shared between all characters. The active profile is stored per character.
---
---@class Profiles
---@field NAMESPACE_AUTOROLL string
local Profiles = {
    NAMESPACE_AUTOROLL = "AutoRoll",
};
GL.Profiles = Profiles;

local PROFILES = "Profiles";
local ACTIVE_PROFILE_BY_CHAR = "ActiveProfileByChar";

---@param namespace string
---@return table
function Profiles:getProfiles(namespace)
    local key = namespace;
    return GL.Settings:get(key .. "." .. PROFILES, {}) or {};
end

---@param namespace string
---@param profileID string
---@return table|nil { name, data }
function Profiles:getProfile(namespace, profileID)
    local profiles = self:getProfiles(namespace);
    return profiles[profileID];
end

---@param namespace string
---@return string|nil
function Profiles:getActiveProfileID(namespace)
    local key = namespace;
    local byChar = GL.Settings:get(key .. "." .. ACTIVE_PROFILE_BY_CHAR, {});
    return byChar[GL.User.fqn];
end

---@param namespace string
---@return table|nil { name, data } or nil if no active profile
function Profiles:getActiveProfile(namespace)
    local id = self:getActiveProfileID(namespace);
    if (not id) then
        return;
    end
    return self:getProfile(namespace, id);
end

---@param namespace string
---@return table The data of the active profile, or empty table
function Profiles:getProfileData(namespace)
    local profile = self:getActiveProfile(namespace);
    if (profile and profile.data) then
        return profile.data;
    end
    return {};
end

---@param namespace string
---@param data table
---@return nil
function Profiles:setProfileData(namespace, data)
    local profileID = self:getActiveProfileID(namespace);
    if (not profileID) then
        return;
    end

    local key = namespace;
    local path = ("%s.%s.%s.data"):format(key, PROFILES, profileID);
    GL.Settings:set(path, data);
end

---@param namespace string
---@param name string
---@param data? table
---@return string|nil profileID
function Profiles:createProfile(namespace, name, data)
    if (GL:empty(name)) then
        return;
    end

    name = strtrim(tostring(name));
    local profiles = self:getProfiles(namespace);
    for _, profile in pairs(profiles) do
        if (profile.name and GL:iEquals(profile.name, name)) then
            return;
        end
    end

    local profileID = GL:uuid();
    local key = namespace;
    local path = ("%s.%s.%s"):format(key, PROFILES, profileID);
    GL.Settings:set(path, {
        name = name,
        data = data or {},
    });

    self:setActiveProfile(namespace, profileID);
    return profileID;
end

---@param namespace string
---@param sourceProfileID string
---@param newName string
---@return string|nil new profileID
function Profiles:copyProfile(namespace, sourceProfileID, newName)
    local source = self:getProfile(namespace, sourceProfileID);
    if (not source) then
        return;
    end

    local dataCopy = {};
    for k, v in pairs(source.data or {}) do
        dataCopy[k] = v;
    end

    return self:createProfile(namespace, newName or (source.name .. " " .. L["(copy)"]), dataCopy);
end

---@param namespace string
---@param profileID string
---@return nil
function Profiles:deleteProfile(namespace, profileID)
    local profiles = self:getProfiles(namespace);
    if (not profiles[profileID]) then
        return;
    end

    local key = namespace;
    local path = ("%s.%s.%s"):format(key, PROFILES, profileID);
    GL.Settings:set(path, nil);

    -- If we deleted the active profile, switch to another
    if (self:getActiveProfileID(namespace) == profileID) then
        local remaining = self:getProfiles(namespace);
        local nextID = nil;
        for id, _ in pairs(remaining) do
            nextID = id;
            break;
        end
        self:setActiveProfile(namespace, nextID);
    end
end

---@param namespace string
---@param profileID string
---@param newName string
---@return boolean
function Profiles:renameProfile(namespace, profileID, newName)
    newName = strtrim(tostring(newName or ""));
    if (GL:empty(newName)) then
        return false;
    end

    local profile = self:getProfile(namespace, profileID);
    if (not profile) then
        return false;
    end

    local profiles = self:getProfiles(namespace);
    for id, p in pairs(profiles) do
        if (id ~= profileID and p.name and GL:iEquals(p.name, newName)) then
            return false;
        end
    end

    local key = namespace;
    local path = ("%s.%s.%s.name"):format(key, PROFILES, profileID);
    GL.Settings:set(path, newName);
    return true;
end

---@param namespace string
---@param profileID string|nil
---@return nil
function Profiles:setActiveProfile(namespace, profileID)
    local key = namespace;
    local charKey = GL.User.fqn;
    local path = ("%s.%s.%s"):format(key, ACTIVE_PROFILE_BY_CHAR, charKey);
    GL.Settings:set(path, profileID);
end

