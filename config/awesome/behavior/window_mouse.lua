-- window_mouse.lua [_] <;,)~

-- Imports
local gears = require("gears")

-- Code
local function move_mouse(this)
   gears.timer.delayed_call(
      function ()
         if this.valid then
            mouse.coords (
               {
                  x = this.x + this.width  * (this.rel_x or 0.5),
                  y = this.y + this.height * (this.rel_y or 0.5),
               },
               true
            )
         end
      end
   )
end

local function set_mouse(this)
   if this then
      local mouse = mouse.coords()
      this.rel_x = (mouse.x - this.x) / this.width
      this.rel_y = (mouse.y - this.y) / this.height
   end
end

local inhibit_change_signals = true

local function handle_change_signal(this)
   if inhibit_change_signals then
      return
   end

   set_mouse(mouse.current_client)
   move_mouse(this)
end

client.connect_signal(
   "request::manage",
   function (this)
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
   function (this)
      if not (this == mouse.current_client) then
         set_mouse(mouse.current_client)
         move_mouse(this)
      end
   end
)

client.connect_signal("swapped", handle_change_signal)
client.connect_signal("property::floating", handle_change_signal)
client.connect_signal("property::fullscreen", handle_change_signal)
client.connect_signal("property::maximized", handle_change_signal)
