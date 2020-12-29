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
   "manage",
   function (c)
      set_mouse(mouse.current_client)
      c.rel_x = 0.5
      c.rel_y = 0.5
      move_mouse(c)
   end
)

client.connect_signal(
   "property::floating",
   function(c)
      set_mouse(c)
      move_mouse(c)
   end
)
