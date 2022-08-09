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
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Global variables
_G.terminal = os.getenv("TERMINAL") .. " -e tmux"
_G.editor = os.getenv("EDITOR") or "nano"
_G.editor_cmd = _G.terminal .. " -e " .. _G.editor

-- Enable default awful configuration
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Load keys
require("keys")

-- Load behaviors
require("behavior.rules")
require("behavior.sloppy_focus")
require("behavior.window_mouse")

-- Set visuals
beautiful.init(themes_path .. "automata" .. "/theme.lua")
require("theming.decorations")
require("theming.bar")
require("widget.notification_center")

-- Set wallpaper
_G.wallpaper = "wallpaper.jpg"
require("theming.wallpaper")

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
menubar.utils.terminal = _G.terminal

local names = { "1", "2", "3", "4", "5", "6" }
local offsets = { 23, 9 }

for I=1,screen.count() do
   local offset = offsets[I]
   local this_screen = screen[I]

   for i, name in ipairs(names) do
      local tag = awful.tag.add(
         name,
         {
            screen = this_screen,
            layout = awful.layout.layouts[1],
         }
      )

      awful.keyboard.append_global_keybindings(
         {
            -- View tag only.
            awful.key({ _G.modkey }, "#" .. (offset + i),
               function ()
                  if this_screen ~= mouse.screen then
                     awful.screen.focus(this_screen)
                  end
                  tag:view_only()
               end,
               { description = "view tag #"..i, group = "tag" }
            ),
            -- Move client to tag.
            awful.key({ _G.modkey, "Shift" }, "#" .. (offset + i),
               function ()
                  if client.focus then
                     client.focus:move_to_tag(tag)
                  end
               end,
               { description = "move focused client to tag #"..i, group = "tag" }
            )
         }
      )
   end
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
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
         }
      },
      {
         rule_any = { type = { "normal", "dialog" } },
         properties = { titlebars_enabled = true }
      },

   }
)

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

-- Signal function to execute when the screen configuration changes.
screen.connect_signal("added", awesome.restart)
screen.connect_signal("removed", awesome.restart)
