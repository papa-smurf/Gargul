---@type GL
local _, GL = ...;

GL._initRegistry = {};

--- Queue a class for GL:runInits. Call at file scope, after _init is defined.
--- Events, DB, Version, Settings, the chat locale, and GL.FONT are already initialized.
--- dependsOn holds dotted paths on GL ("User", "GDKP.Session") whose _init must finish first.
---@param class table
---@param dependsOn? string[]
---@return nil
function GL:registerForInit(class, dependsOn)
    dependsOn = dependsOn or {};

    local label = "?";
    if (type(debug) == "table" and type(debug.getinfo) == "function") then
        -- pcall adds a frame, so 3 is the file that called registerForInit
        local ok, caller = pcall(debug.getinfo, 3, "S");
        if (ok and type(caller) == "table") then
            label = caller.short_src or caller.source or label;
        end
    end

    if (type(class) ~= "table" or type(class._init) ~= "function") then
        GL:error(("registerForInit expected a class with _init (%s)"):format(label));
        return;
    end

    if (type(dependsOn) ~= "table") then
        GL:error(("registerForInit dependencies must be a list of dotted paths (%s)"):format(label));
        return;
    end

    for _, path in pairs(dependsOn) do
        if (type(path) ~= "string" or path == "") then
            GL:error(("registerForInit dependency must be a dotted path (%s)"):format(label));
            return;
        end
    end

    self._initRegistry = self._initRegistry or {};
    for index = 1, #self._initRegistry do
        if (self._initRegistry[index].class == class) then
            GL:error(("registerForInit called twice (%s)"):format(label));
            return;
        end
    end

    tinsert(self._initRegistry, {
        class = class,
        dependsOn = dependsOn,
        label = label,
    });
end

--- Initialize every class queued with GL:registerForInit, dependencies first.
---@return nil
function GL:runInits()
    local Registry = self._initRegistry or {};
    local total = #Registry;
    local ran = {};
    local finished = {};
    local done = {};
    local remaining = total;

    while (remaining > 0) do
        local progressed = false;

        for index = 1, total do
            if (not done[index]) then
                local entry = Registry[index];
                local ready = true;
                local giveUp = false;

                for depIndex = 1, #entry.dependsOn do
                    local path = entry.dependsOn[depIndex];
                    local dependency = GL:tableGet(self, path);

                    if (type(dependency) ~= "table") then
                        GL:error(("Init dependency '%s' was not found (%s)"):format(path, entry.label));
                        giveUp = true;
                        break;
                    end

                    if (not dependency._initialized and not ran[dependency]) then
                        if (finished[dependency]) then
                            GL:error(("Init dependency '%s' did not initialize (%s)"):format(path, entry.label));
                            giveUp = true;
                        else
                            local registered = false;
                            for other = 1, total do
                                if (Registry[other].class == dependency) then
                                    registered = true;
                                    break;
                                end
                            end

                            if (not registered) then
                                GL:error(("Init dependency '%s' never registered (%s)"):format(path, entry.label));
                                giveUp = true;
                            else
                                ready = false;
                            end
                        end

                        break;
                    end
                end

                if (giveUp or ready) then
                    if (ready and not giveUp) then
                        entry.class:_init();
                        ran[entry.class] = true;
                    end

                    finished[entry.class] = true;
                    done[index] = true;
                    remaining = remaining - 1;
                    progressed = true;
                end
            end
        end

        if (not progressed) then
            local waiting = {};
            for index = 1, total do
                if (not done[index]) then
                    local detail = Registry[index].label;
                    if (#Registry[index].dependsOn > 0) then
                        detail = ("%s (after %s)"):format(detail, table.concat(Registry[index].dependsOn, ", "));
                    end

                    tinsert(waiting, detail);
                end
            end

            GL:error(("Init dependency cycle: %s"):format(table.concat(waiting, ", ")));
            return;
        end
    end
end
