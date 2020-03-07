-- Imports
local gears = require("gears")

-- Code
local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local cmd = {}

function cmd.toggle_fullscreen(c)
   c.fullscreen = not c.fullscreen
   c:raise()
end

function cmd.toggle_max(c)
   c.maximized = not c.maximized
   c:raise()
end

function cmd.toggle_float(c)
   c.floating = not c.floating
   c:raise()
end

function cmd.prompt()
   awful.screen.focused().mypromptbox:run()
end

function cmd.inc_layout(i)
   local s = awful.screen.focused()
   awful.layout.inc(i, s)
end

-- Exports
local exports = {
   cmd = cmd,
   read_file = read_file,
}

return exports

