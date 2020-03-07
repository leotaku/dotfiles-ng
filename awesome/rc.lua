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
-- Large parts have been stolen from Elenapan, thanks

-- Setup
local config_path = os.getenv("HOME") .. "/.config/awesome/"
local themes_path = config_path .. "theming/"
require("lib.errors")

-- Themes
local theme_collection = {
   "automata"
};

-- Change this number to use a different theme
local theme_name = theme_collection[1]

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
beautiful.init(themes_path .. theme_name .. "/theme.lua")
require("theming.wallpaper")

-- Widgets
require("widget.org_agenda")

if theme_name == "automata" then
   require("theming.decorations")
   require("theming.bar")
end

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

local names = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" }
local tags = {}

function mod0(m, i)
   local n = i % m
   if n == 0 then
      return m
   else
      return n
   end
end

function screen_for(i)
   local id = mod0(#screen, i)
   return screen[id]
end

for i, name in ipairs(names) do
   local tag = awful.tag.add(
      name,
      {
         screen = screen[1],
         layout = awful.layout.layouts[1],
      }
   )

   table.insert(tags, tag)

   globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
         function ()
            -- awful.screen.focus(tag.screen)
            tag:view_only()
         end,
         { description = "view tag #"..i, group = "tag" }
      ),
      -- Move client to tag.
      awful.key(
         { modkey, "Shift" }, "#" .. i + 9,
         function ()
            if client.focus then
               client.focus:move_to_tag(tag)
            end
         end,
         { description = "move focused client to tag #"..i, group = "tag" }
      )
   )

end

tag.connect_signal(
   "request::screen",
   function(t)
      for s in screen do
         if s ~= t.screen and
            s.geometry.x == t.screen.geometry.x and
            s.geometry.y == t.screen.geometry.y and
            s.geometry.width == t.screen.geometry.width and
         s.geometry.height == t.screen.geometry.height then
            local t2 = awful.tag.find_by_name(s, t.name)
            if t2 then
               t:swap(t2)
            else
               t.screen = s
            end
            return
         end
      end
end)

awful.screen.connect_for_each_screen(
   function(s)
      -- View tag one
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
            -- local f = awful.placement.scale + awful.placement.centered
            -- f(c, {to_percent = 0.25})
            awful.placement.centered(f)
         end
      end

      if awesome.startup
         and not c.size_hints.user_position
      and not c.size_hints.program_position then
         -- Prevent clients from being unreachable after screen count changes.
         awful.placement.no_offscreen(c)
      end
   end
)
