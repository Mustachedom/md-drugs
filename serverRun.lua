function loadFile(filePath)
    local resourceName = 'md-drugs'
    local fullScript = LoadResourceFile(resourceName, filePath)
    if not fullScript then
        ps.error("Error: Failed to load module '" .. filePath .. "' from resource '" .. resourceName .. "'.")
        return false
    end
    local chunk, err = load(fullScript, filePath, "t")
    if not chunk then
        ps.error("Error loading Lua chunk from '" .. filePath .. "': " .. tostring(err))
        return false
    end

    local success, execErr = pcall(chunk)
    if not success then
        ps.error("Error executing Lua chunk from '" .. filePath .. "': " .. tostring(execErr))
        return false
    end
    return true
end

for scriptName, toggle in pairs(Config.Drugs) do
    if not toggle then goto continue end
    loadFile('server/' .. scriptName .. '.lua')
    ::continue::
end