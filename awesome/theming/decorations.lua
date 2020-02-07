--         .:'
--     __ :'__
--  .'`__`-'__``.
-- :__________.-'
-- :_________: decorations.lua
--  :_________`-;
--   `.__.-.__.'

-- Art by Joan G. Stark

-- Imports
beautiful = require("beautiful")
wibox     = require("wibox")

-- Locals
local dpi = beautiful.xresources.apply_dpi

-- Code
function handle_float(c)
   if c.floating then
      awful.titlebar(
         c,
         {
            size      = dpi(5),
            position  = "left",
            bg_focus  = beautiful.red,
            bg_normal = beautiful.black,
         }
      )
   else
      awful.titlebar(
         c,
         {
            size      = dpi(5),
            position  = "left",
            bg_focus  = beautiful.blue,
            bg_normal = beautiful.black,
         }
      )
   end
end


client.connect_signal(
   "manage",
   function(c)
      local bar = awful.titlebar(
         c,
         {
            size      = dpi(5),
            position  = "left",
            bg_focus  = beautiful.blue,
            bg_normal = beautiful.black,
         }
      )
      handle_float(c)
   end
)

client.connect_signal(
   "unfocus",
   function(c)
      c.border_color = beautiful.white
   end
)

client.connect_signal(
   "focus",
   function(c)
      c.border_color = beautiful.white
   end
)

client.connect_signal(
   "property::maximized",
   function(c)
      if c.maximized then
         awful.titlebar.hide(c, "left")
         c.width = c.width + dpi(5)
      else
         awful.titlebar.show(c, "left")
      end
   end
)

client.connect_signal(
   "property::floating",
   handle_float
)
