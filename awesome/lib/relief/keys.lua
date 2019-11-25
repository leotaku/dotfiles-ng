--  ____ ____ ____ ____ ____ ____ ____ ____ 
-- ||k |||e |||y |||s |||. |||l |||u |||a ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- Locals
unpack = table.unpack

-- Imports
gears = require("gears")
awful = require("awful")

-- Code
local function translate_key(key)
   if     key == "M" then
      return _G.modkey
   elseif key == "M1" then
      return "Mod1"
   elseif key == "M2" then
      return "Mod2"
   elseif key == "M3" then
      return "Mod3"
   elseif key == "M4" then
      return "Mod4"
   elseif key == "M5" then
      return "Mod5"
   elseif key == "A" then
      return "Alt"
   elseif key == "S" then
      return "Shift"
   elseif key == "C" then
      return "Control"
   end
end

local function translate_seq(sequence)
   keys = gears.string.split(sequence, "-")
   key = keys[#keys]

   mods={}
   for i,key in pairs(keys) do
      if (i ~= #keys) then
         mods[i] = translate_key(key)
      end
   end
   return mods, key
end

local function key(keyseq, press, ...)
   local args = {...}
   local mods, key = translate_seq(keyseq)
   local func

   if args[1] == "self" then
      func = function(self)
         args[1] = self
         press(unpack(args))
      end
   else
      func = function ()
         press(unpack(args))
      end
   end
   
   return awful.key(mods, key, func)
end

local function bindkeys(keytable, ...)
   for _,tbl in pairs({...}) do
      keytable = gears.table.join(
         keytable,
         key(unpack(tbl))
      )
   end
   return keytable
end

-- Exports
local exports = {
   key = key,
   bindkeys = bindkeys,
}

return exports
