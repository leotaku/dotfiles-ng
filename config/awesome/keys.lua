--  ____ ____ ____ ____ ____ ____ ____ ____
-- ||k |||e |||y |||s |||. |||l |||u |||a ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- Imports
local relief = require("lib.relief")
local utils = require("lib.utils")
local cmd = utils.cmd

-- Setup
_G.modkey = "Mod4"

-- Key bindings
local globalkeys = relief.keys.bindkeys(
   {},
   -- Focus
   {"M-space", cmd.inc_layout, 1},
   {"M-Tab", awful.client.focus.byidx, 1},
   -- Layout
   {"M-m", cmd.toggle_tag_max},
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
   {"M-Return", awful.spawn, _G.terminal or "xterm"},
   {"M-d", awful.spawn, "rofi -show drun"},
   -- AwesomeWM
   {"F9", awesome.restart}
)

local clientkeys = relief.keys.bindkeys(
   {},
   {"M-x", relief.method2curry("kill"), "self"},
   {"M-f", cmd.toggle_fullscreen, "self"},
   {"M-n", cmd.toggle_float, "self"},
   {"M-s", awful.placement.centered, "self"}
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
