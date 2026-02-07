---@type GL
local _, GL = ...;

local Constants = GL.Data.Constants;

---@param str string
---@param color string
---@return string
function GL:colorize(str, color)
    return ("|c00%s%s|r"):format(color, str);
end

---@param var string
---@param class string
---@return string
function GL:classColorize(var, class)
    class = class and strupper(class) or class;
    local classColor = { GetClassColor(class or "PRIEST") };
    return ("|c%s%s|r"):format(classColor[4], var);
end

--- Get a class' RGBA color by a given class name
---
---@param className string
---@param default table|nil
---@return table
function GL:classRGBAColor(className, default)
    default = default or Constants.classRGBAColors.priest;

    if (not className or type(className) ~= "string") then
        return default;
    end

    return GL:tableGet(
        Constants.classRGBAColors,
        strlower(className),
        default
    );
end

--- Get a class' RGB color by a given class name
---
---@param className string
---@param default string|nil
---@return table
function GL:classRGBColor(className, default)
    default = default or Constants.classRGBColors.priest;

    if (not className
        or type(className) ~= "string"
    ) then
        return default;
    end

    return GL:tableGet(
        Constants.classRGBColors,
        strlower(className),
        default
    );
end

--- Get a class' HEX color by a given class name
---
---@param className string
---@param default string|nil
---@return string
function GL:classHexColor(className, default)
    default = default or Constants.ClassHexColors.priest;

    if (not className or type(className) ~= "string") then
        return default;
    end

    return GL:tableGet(
        Constants.ClassHexColors,
        strlower(className),
        default
    );
end

--- Strip color tags from a string
---
---@param text string
---@return string
function GL:stripColor(text)
    text = string.gsub(text or "", "|c%x%x%x%x%x%x%x%x", "" );
    text = string.gsub(text, "|c%x%x %x%x%x%x%x", "" );
    text = string.gsub(text, "|r", "" );

    return text;
end
