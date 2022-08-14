-- window_mouse.lua [_] <;,)~

-- Imports
local gears = require("gears")

-- Code
local function move_mouse(self, fixed)
   gears.timer.delayed_call(
      function ()
         if self and self.valid then
            if not self.rel_x or (self.rel_x <= 0 or self.rel_x >= 1) then
               self.rel_x = 0.5
            end
            if not self.rel_y or (self.rel_y <= 0 or self.rel_y >= 1) then
               self.rel_y = 0.5
            end
            if fixed then
               mouse.coords (
                  {
                     x = self.x + self.width  * 0.5,
                     y = self.y + self.height * 0.5,
                  },
                  true
               )
            else
               mouse.coords (
                  {
                     x = self.x + self.width  * self.rel_x,
                     y = self.y + self.height * self.rel_y,
                  },
                  true
               )
            end
         end
      end
)
end

local function set_mouse(self)
   if self and self.valid then
      local mouse = mouse.coords()
      self.rel_x = (mouse.x - self.x) / self.width
      self.rel_y = (mouse.y - self.y) / self.height
   end
end

local inhibit_change_signals = true

client.connect_signal(
   "request::manage",
   function ()
      inhibit_change_signals = true
      gears.timer.delayed_call(
         function ()
            inhibit_change_signals = false
         end
      )
   end
)

client.connect_signal(
   "request::activate",
   function (self)
      if inhibit_change_signals then return end
      if not (self == mouse.current_client) then
         set_mouse(mouse.current_client)
         move_mouse(self)
      end
   end
)

client.connect_signal(
   "swapped",
   function (self)
      if inhibit_change_signals then return end
      set_mouse(mouse.current_client)
      move_mouse(self)
   end
)
client.connect_signal(
   "property::floating",
   function (self)
      if inhibit_change_signals then return end
      set_mouse(mouse.current_client)
      move_mouse(self)
   end
)
client.connect_signal(
   "property::fullscreen",
   function (self)
      if inhibit_change_signals then return end
      set_mouse(mouse.current_client)
      move_mouse(self, true)
   end
)
client.connect_signal(
   "property::maximized",
   function (self)
      if inhibit_change_signals then return end
      set_mouse(mouse.current_client)
      move_mouse(self)
   end
)
tag.connect_signal(
   "property::layout",
   function ()
      if inhibit_change_signals then return end
      set_mouse(mouse.current_client)
      move_mouse(mouse.current_client)
   end
)
