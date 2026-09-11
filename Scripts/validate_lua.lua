--[[
    Validate Lua 5.1 syntax for Gargul addon files, using the interpreter's own parser.

    Run it with the bundled interpreter (no install needed):
      Scripts\bin\lua5.1.exe Scripts\validate_lua.lua                      -- every .lua file
      Scripts\bin\lua5.1.exe Scripts\validate_lua.lua Classes\Player.lua   -- specific files
      Scripts\bin\lua5.1.exe Scripts\validate_lua.lua Classes              -- a directory
]]

local SKIP_DIRS = { ".git", "Libs", "automations", "Data", "Scripts", };

---@return string
local function currentDirectory()
    local Pipe = io.popen("cd");
    local path = Pipe:read("*l");
    Pipe:close();

    return path;
end

--- Turn a path into a backslashed absolute-ish form with "." and ".." resolved.
---@return string
local function normalize(path)
    path = path:gsub("/", "\\");
    path = path:gsub("\\+$", "");
    path = path:gsub("\\%.\\", "\\");
    path = path:gsub("\\%.$", "");

    while (true) do
        local resolved, count = path:gsub("\\[^\\]+\\%.%.", "", 1);
        if (count == 0) then
            break;
        end

        path = resolved;
    end

    return path;
end

---@return string
local function absolute(path)
    path = normalize(path);
    if (path:match("^%a:")) then
        return path;
    end

    return normalize(currentDirectory() .. "\\" .. path);
end

local scriptPath = normalize(arg[0]);
local root = absolute((scriptPath:match("^(.*)\\[^\\]*$") or ".") .. "\\..");

---@return string
local function relativePath(path)
    if (path:sub(1, #root + 1):lower() == (root .. "\\"):lower()) then
        return path:sub(#root + 2);
    end

    return path;
end

---@return boolean
local function skipped(name)
    local padded = "\\" .. name .. "\\";
    for _, directory in ipairs(SKIP_DIRS) do
        if (padded:find("\\" .. directory .. "\\", 1, true)) then
            return true;
        end
    end

    return false;
end

local Files = {};
local seen = {};

---@return nil
local function addFile(path)
    path = absolute(path);

    local name = relativePath(path);
    if (seen[name:lower()]) then
        return;
    end

    seen[name:lower()] = true;
    Files[#Files + 1] = { path = path, name = name, };
end

--- Add every .lua file below a directory, minus the ones we never check.
---@return nil
local function addDirectory(directory)
    local Pipe = io.popen(("dir /b /s \"%s\\*.lua\" 2>nul"):format(normalize(directory)));
    for line in Pipe:lines() do
        local path = normalize(line);
        if (not skipped(relativePath(path))) then
            addFile(path);
        end
    end
    Pipe:close();
end

--- Compile the file without running it. Returns false plus the parse error on bad syntax.
---@return boolean, string?
local function validate(File)
    local Handle, openError = io.open(File.path, "rb");
    if (not Handle) then
        return false, openError or "could not open file";
    end

    local source = Handle:read("*a");
    Handle:close();

    -- Lua 5.1 refuses to parse a UTF-8 BOM, WoW strips it for us.
    source = source:gsub("^\239\187\191", "");

    local chunk, syntaxError = loadstring(source, "@" .. File.name);
    if (chunk) then
        return true;
    end

    return false, syntaxError;
end

if (#arg == 0) then
    addDirectory(root);
else
    for _, target in ipairs(arg) do
        if (target:lower():sub(-4) == ".lua") then
            addFile(target);
        else
            addDirectory(target);
        end
    end
end

if (#Files == 0) then
    print("No .lua files found to validate.");
    os.exit(0);
end

table.sort(Files, function (First, Second)
    return First.name:lower() < Second.name:lower();
end);

local failures = 0;
for _, File in ipairs(Files) do
    local ok, message = validate(File);

    if (ok) then
        print("OK   " .. File.name);
    else
        failures = failures + 1;
        print("FAIL " .. File.name);
        print("     " .. tostring(message));
    end
end

print("");
if (failures > 0) then
    print(("%d of %d file(s) failed validation."):format(failures, #Files));
    os.exit(1);
end

print(("All %d file(s) passed."):format(#Files));
os.exit(0);
