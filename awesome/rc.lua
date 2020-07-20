--    ,---.            ,-.-.     ,----.    ,-,--.    _,.---._           ___      ,----.
--  .--.'  \  ,-..-.-./  \==\ ,-.--` , \ ,-.'-  _\ ,-.' , -  `.  .-._ .'=.'\  ,-.--` , \
--  \==\-/\ \ |, \=/\=|- |==||==|-  _.-`/==/_ ,_.'/==/_,  ,  - \/==/ \|==|  ||==|-  _.-`
--  /==/-|_\ ||- |/ |/ , /==/|==|   `.-.\==\  \  |==|   .=.     |==|,|  / - ||==|   `.-.
--  \==\,   - \\, ,     _|==/==/_ ,    / \==\ -\ |==|_ : ;=:  - |==|  \/  , /==/_ ,    /
--  /==/ -   ,|| -  -  , |==|==|    .-'  _\==\ ,\|==| , '='     |==|- ,   _ |==|    .-'
-- /==/-  /\ - \\  ,  - /==/|==|_  ,`-._/==/\/ _ |\==\ -    ,_ /|==| _ /\   |==|_  ,`-._
-- \==\ _.\=\.-'|-  /\ /==/ /==/ ,     /\==\ - , / '.='. -   .' /==/  / / , /==/ ,     /
--  `--`        `--`  `--`  `--`-----``  `--`---'    `--`--''   `--`./  `--``--`-----``

-- My AwesomeWM configuration

-- Setup
local config_path = os.getenv("HOME") .. "/.config/awesome/"
local themes_path = config_path .. "theming/"
require("lib.errors")

-- Import libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Local functions
local dpi = beautiful.xresources.apply_dpi

-- Global variables
_G.terminal = "urxvtc -e tmux"
_G.editor = os.getenv("EDITOR") or "nano"
_G.editor_cmd = terminal .. " -e " .. editor

-- Enable default awful configuration
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Load keys
local keys = require("keys")
local globalkeys = keys.globalkeys

-- Load behaviors
require("behavior.rules")
require("behavior.sloppy_focus")
require("behavior.window_mouse")

-- Set visuals
beautiful.init(themes_path .. "automata" .. "/theme.lua")

-- Set wallpaper
_G.wallpaper = os.getenv("HOME") .. "/.wallpaper.jpg"
require("theming.wallpaper")

-- Widgets
require("theming.decorations")
require("theming.bar")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.max,
   awful.layout.suit.tile,
   awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
   -- awful.layout.suit.fair,
   -- awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
   -- awful.layout.suit.floating,
}

-- Menubar configuration
menubar.utils.terminal = terminal

local names = { "I", "II", "III", "IV", "V", "VI" }

for i, name in ipairs(names) do
   local tag = awful.tag.add(
      name,
      {
         screen = screen[1],
         layout = awful.layout.layouts[1],
      }
   )

   globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 23,
         function ()
            if awful.screen.focused == tag.screen then
               awful.screen.focus(tag.screen)
            end
            tag:view_only()
         end,
         { description = "view tag #"..i, group = "tag" }
      ),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 23,
         function ()
            if client.focus then
               client.focus:move_to_tag(tag)
            end
         end,
         { description = "move focused client to tag #"..i, group = "tag" }
      )
   )
end

awful.screen.connect_for_each_screen(
   function(s)
      -- View only one tag
      local tag = s.tags[1]
      if tag then
         tag:view_only()
      end
   end
)

awful.rules.rules = gears.table.join(
   awful.rules.rules,
   {
      {
         rule = { },
         properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
         }
      }
   }
)

-- Set keys
root.keys(globalkeys)

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function (c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      if not awesome.startup then
         awful.client.setslave(c)
         if c.floating then
            if c.height/awful.screen.focused().geometry.height > 0.75 then
               awful.placement.scale(c, {to_percent = 0.75})
            end
            awful.placement.centered(c)
         end
      end

      -- Prevent clients from being unreachable after screen count changes.
      if awesome.startup then
         awful.placement.no_offscreen(c)
      end
   end
)
