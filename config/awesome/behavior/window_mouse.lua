-- window_mouse.lua [_] <;,)~

-- Imports
local gears = require("gears")

-- Code
local function move_mouse(c)
   gears.timer.delayed_call(
      function ()
         if c.valid then
            mouse.coords (
               {
                  x = c.x + c.width  * (c.rel_x or 0.5),
                  y = c.y + c.height * (c.rel_y or 0.5),
               },
               true
            )
         end
      end
   )
end

local function set_mouse(c)
   if c then
      local m = mouse.coords()
      c.rel_x = (m.x - c.x) / c.width
      c.rel_y = (m.y - c.y) / c.height
   end
end

local inhibit_change_signals = true

client.connect_signal(
   "manage",
   function (c)
      inhibit_change_signals = true
      gears.timer.delayed_call(
         function ()
            inhibit_change_signals = false
         end
      )
   end
)


client.connect_signal(
   "focus",
   function (c)
      if not (c == mouse.current_client) then
         set_mouse(mouse.current_client)
         move_mouse(c)
      end
   end
)

client.connect_signal(
   "swapped",
   function(c, C)
      if inhibit_change_signals then
         return
      end

      set_mouse(mouse.current_client)
      move_mouse(c)
   end
)

client.connect_signal(
   "property::floating",
   function(c)
      if inhibit_change_signals then
         return
      end

      set_mouse(mouse.current_client)
      move_mouse(c)
   end
)
