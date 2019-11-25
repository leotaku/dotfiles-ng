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
config_path = os.getenv("HOME") .. "/.config/awesome/"
themes_path = config_path .. "theme/"
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

-- Enable default awful configuration
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Load behaviors
local keys = require("keys")
require("behavior.rules")
require("behavior.sloppy_focus")
require("behavior.window_mouse")

-- Set visuals
beautiful.init(themes_path .. theme_name .. "/theme.lua")
if theme_name == "automata" then
   require("bar.b2")
   require("decoration.macos")
end
--require("themes.basics")

-- Set variables
terminal = "urxvtc -e tmux"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

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
      awful.layout.suit.floating,
}

client.connect_signal(
   "manage",
   function (c)
      c.shape = function(cr,w,h)
         gears.shape.rounded_rect(cr,w,h,5)
      end
   end
)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Run new test configurations
require("testing")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

awful.screen.connect_for_each_screen(
   function(s)
      -- Set the wallpaper.
      set_wallpaper(s)
      -- Each screen has its own tag table.
      awful.tag({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" }, s, awful.layout.layouts[1])
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
);

-- Set keys
root.keys(keys.globalkeys)

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function (c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- if not awesome.startup then awful.client.setslave(c) end
      if not awesome.startup then
         awful.client.setslave(c)
      end

      if awesome.startup
         and not c.size_hints.user_position
      and not c.size_hints.program_position then
         -- Prevent clients from being unreachable after screen count changes.
         awful.placement.no_offscreen(c)
      end
   end
)
