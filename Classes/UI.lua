local _, App = ...;

App.UI = {};
local UI = App.UI;
UI.components = {};

function UI:createFrame(...)
    local type, identifier, parent, inheritsFrom = ...;
    local frame = CreateFrame(type, identifier, parent, inheritsFrom);

    UI.components[identifier] = frame;

    return frame;
end

function UI:show(identifier)
    if (not UI.components[identifier]) then
        App:debug(identifier .. " has not been created yet");
        return;
    elseif (UI.components[identifier]:IsVisible()) then
        App:debug(identifier .. " is already visible");
        return;
    end

    UI.components[identifier]:Show();
end

function UI:hide(identifier)
    if (not UI.components[identifier]) then
        App:debug(identifier .. " has not been created yet");
        return;
    elseif (not UI.components[identifier]:IsVisible()) then
        App:debug(identifier .. " is not visible");
        return;
    end

    UI.components[identifier]:Hide();
end

function UI:hideAll()
    if (not #UI.components) then
        App:debug("No components have been created yet");
        return;
    end
end

App:debug("UI.lua");