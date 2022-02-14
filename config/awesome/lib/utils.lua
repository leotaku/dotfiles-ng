-- Imports
local gears = require("gears")

-- Code
local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

local cmd = {}

function cmd.inc_layout(i)
   local s = awful.screen.focused()
   awful.layout.inc(i, s)
end

function cmd.inc_client(i)
   if not client.focus.fullscreen then
      awful.client.focus.byidx(i)
   end
end

function cmd.toggle_tag_max()
   local ln = awful.layout.getname()
   local c = mouse.current_client
   if c == nil then
      return
   end

   c.fullscreen = false
   if ln == "max" then
      awful.layout.inc(1)
      awful.layout.remove_default_layout(awful.layout.suit.max)
   else
      awful.layout.append_default_layout(awful.layout.suit.max)
      awful.layout.set(awful.layout.suit.max)
   end
end

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

-- Exports
local exports = {
   cmd = cmd,
   read_file = read_file,
}

return exports

