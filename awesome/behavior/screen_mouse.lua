-- screen_mouse [_] <&,,)~

-- Imports
awful = require("awful")

-- Code
local old_tag = awful.screen.focused().selected_tag

function remember_mouse(new_tag)
   if new_tag and old_tag then
      old_tag.saved_mouse = mouse.coords()
      if new_tag.saved_mouse then
         mouse.coords(new_tag.saved_mouse)
      end
   end
   old_tag = new_tag
end

tag.connect_signal("property::selected", remember_mouse)
