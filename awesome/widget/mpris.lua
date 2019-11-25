-- A mpris music widget using playerctl

-- Imports
local awful = require("awful")
local wibox = require("wibox")
local utils = require("lib.utils")

-- Locals
local dpi = require("beautiful.xresources").apply_dpi

-- Code
function spawn_widget(tbl)
   widget = wibox({
         screen = tbl.screen,
         visible = true,
         width = 300,
         height = 300,
         bg = "#000000",
         shape = utils.rrect(beautiful.border_radius),
         ontop = true,
   })

   awful.placement.top_right(widget, { margins = 10 }) 
   
   widget:setup {
      {layout = wibox.container.margin},
      {
         markup = '0 - 0';
         layout = wibox.widget.textbox,
         align = 'center',
         valign = 'center',
      },
      {layout = wibox.container.margin},
      layout = wibox.layout.align.vertical,
   }
end

-- Exports
return {
   widget = spawn_widget,
}
