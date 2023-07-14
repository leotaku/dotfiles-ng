--      _
--  _n_|_|_,_
-- |===.-.===|
-- |  ((_))  | wallpaper.lua
-- '==='-'==='

-- Art by Joan G. Stark

-- Imports
local awful = require("awful")
local gears = require("gears")

-- Code
local function find_wallpaper(filename)
   for _, path in ipairs({
         os.getenv("HOME") .. "/.config/awesome" .. "/" .. filename,
         os.getenv("HOME") .. "/.config" .. "/" .. filename,
         os.getenv("HOME") .. "/" .. filename,
         filename,
   }) do
      local f = io.open(path, "r")
      if f then
         io.close(f)
         return path
      end
   end
end

local wallpaper = find_wallpaper(_G.wallpaper)

local function set_wallpaper(s)
   if wallpaper then
      -- If wallpaper is a list, select a random one
      if type(wallpaper) == "table" then
         wallpaper = wallpaper[math.random(#wallpaper)]
      end
      gears.wallpaper.maximized(wallpaper, s)
   end
end

awful.screen.connect_for_each_screen(set_wallpaper)
