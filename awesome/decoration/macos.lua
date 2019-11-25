--           .:'
--       __ :'__
--    .'`__`-'__``.
--   :__________.-'
--   :_________:
--    :_________`-;
-- jgs `.__.-.__.'   macOS.lua

-- Imports
beautiful = require("beautiful")
wibox     = require("wibox")

-- Locals
local dpi = beautiful.xresources.apply_dpi

-- Code
client.connect_signal(
   "manage",
   function(c)
      local bar = awful.titlebar(
         c,
         {
            size      = dpi(5),
            position  = "top",
            bg_focus  = beautiful.blue,
            bg_normal = beautiful.white,
         }
      )
      bar:setup {
         {
            top    = dpi(5),
            color = beautiful.darkyellow,
            widget = wibox.container.margin,
         },
         layout = wibox.layout.fixed.vertical
      }
   end
)

client.connect_signal(
   "unfocus",
   function(c)
      c.border_color = beautiful.border_normal
   end
)

client.connect_signal(
   "focus",
   function(c)
      c.border_color = beautiful.border_normal
   end
)
