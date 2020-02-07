--  ____ ____ ____ ____ ____ ____ ____ ____ 
-- ||k |||e |||y |||s |||. |||l |||u |||a ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- Imports
relief = require("lib.relief")

-- Code

-- Setup
modkey = "Mod4"

-- Helpers
local helpers = {}
function helpers.toggle_fullscreen(c)
   c.fullscreen = not c.fullscreen
   c:raise()
end

function helpers.toggle_max(c)
   c.maximized = not c.maximized
   c:raise()
end

function helpers.toggle_float(c)
   c.floating = not c.floating
   c:raise()
end

function helpers.prompt()
   awful.screen.focused().mypromptbox:run()
end

function helpers.inc_layout(i)
   local s = awful.screen.focused()
   awful.layout.inc(i, s)
end

-- Key bindings
local globalkeys = relief.keys.bindkeys(
   {},
   -- Focus
   {"M-space", awful.screen.focus_relative, 1},
   {"M-Tab", awful.client.focus.byidx, 1},
   -- Layout
   --{"M-space", helpers.inc_layout, 1},
   -- Directional focus
   {"M-h", awful.client.focus.bydirection, "left"},
   {"M-j", awful.client.focus.bydirection, "down"},
   {"M-k", awful.client.focus.bydirection, "up"},
   {"M-l", awful.client.focus.bydirection, "right"},
   -- Directional swap
   {"M-Left",  awful.client.swap.bydirection, "left"},
   {"M-Down",  awful.client.swap.bydirection, "down"},
   {"M-Up",    awful.client.swap.bydirection, "up"},
   {"M-Right", awful.client.swap.bydirection, "right"},
   -- Spawn apps
   -- TODO: put environment variables in separate file
   {"M-Return", awful.spawn, "urxvtc -e tmux"},
   {"M-d", awful.spawn, "rofi -show drun"},
   -- AwesomeWM
   {"F9", awesome.restart}
)

local clientkeys = relief.keys.bindkeys(
   {},
   {"M-x", relief.method2curry("kill"), "self"},
   {"M-f", helpers.toggle_max, "self"},
   {"M-m", helpers.toggle_float, "self"}
   -- {"M-f", helpers.toggle_fullscreen, "self"},
)

local clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Exports
return {
   globalkeys = globalkeys,
   clientbuttons = clientbuttons,
   clientkeys = clientkeys,
}
