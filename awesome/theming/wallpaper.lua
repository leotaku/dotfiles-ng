--      _
--  _n_|_|_,_
-- |===.-.===|
-- |  ((_))  | wallpaper.lua
-- '==='-'==='

-- Art by Joan G. Stark

-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- Code
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

awful.screen.connect_for_each_screen(set_wallpaper)
