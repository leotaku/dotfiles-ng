--  __         ___      ___                        
-- /\ \      /'___`\   /\_ \                       
-- \ \ \____/\_\ /\ \  \//\ \    __  __     __     
--  \ \ '__`\/_/// /__   \ \ \  /\ \/\ \  /'__`\   
--   \ \ \L\ \ // /_\ \__ \_\ \_\ \ \_\ \/\ \L\.\_ 
--    \ \_,__//\______/\_\/\____\\ \____/\ \__/.\_\
--     \/___/ \/_____/\/_/\/____/ \/___/  \/__/\/_/
--

-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Local
local dpi = beautiful.xresources.apply_dpi

-- Code
local helper = {}
helper.sep = wibox.widget {
   markup = "|",
   widget = wibox.widget.textbox,
}
helper.empty = wibox.widget {
   layout = wibox.container.margin,
}


local function create_slider(arg)
   local slider = wibox.widget {
      opacity             = 0,
      value               = arg.value,
      maximum             = arg.maximum,
      minimum             = arg.minimum,
      widget              = wibox.widget.slider,
   }
   local progress = wibox.widget {
      shape = gears.shape.rounded_rect,
      max_value = arg.maximum,
      value = arg.value,
      widget = wibox.widget.progressbar,
      color = arg.color,
      background_color = arg.background_color,
   }

   slider:connect_signal(
      "property::value",
      function (w)
         if arg.callback then
            arg.callback(w.value)
         end
         progress:set_value(w.value)
      end
   )

   return wibox.widget {
      slider,
      {
         progress,
         top = dpi(7),
         bottom = dpi(7),
         layout = wibox.container.margin,
      },
      layout = wibox.layout.stack,
   }
end

local light_slider = create_slider {
   color = beautiful.yellow,
   background_color = beautiful.darkyellow,
   value = 0,
   maximum = 1000,
   minimum = 1,
   callback = function (value)
      awful.spawn("light -S "..value/10)
   end
}

local pulse_slider = create_slider {
   color = beautiful.darkred,
   background_color = beautiful.red,
   value = 0,
   maximum = 15000,
   minimum = 0,
   callback = function (value)
      awful.spawn("pactl set-sink-volume 0 0x"..value)
   end
}

local battery_slider = create_slider {
   color = beautiful.green,
   background_color = beautiful.darkgreen,
   value = 0,
   maximum = 1000,
   minimum = 0,
}

local function create(s)
   s.mypromptbox = awful.widget.prompt {
      prompt = 'Execute: '
   }
   s.mylayoutbox = awful.widget.layoutbox(s)
   s.mytaglist = awful.widget.taglist {
      screen = s,
      filter  = awful.widget.taglist.filter.all,
      layout   = {
         spacing = dpi(7),
         spacing_widget = helper.sep,
         layout  = wibox.layout.fixed.horizontal,
      },
   }
   
   s.top_bar = awful.wibar(
      {
         position = "top",
         screen = s,
         width = s.geometry.width,
         -- height = dpi(27),
         bg = beautiful.color15,
      }
   )
   
   s.top_bar:setup {
      {
         -- Actual bar
         {
            -- Start section
            {
               s.mytaglist,
               {
                  s.mypromptbox,
                  layout = wibox.layout.fixed.horizontal,
               },
               layout = wibox.layout.stack,
            },
            -- Middle section
            {
               {
                  {
                     light_slider,
                     pulse_slider,
                     battery_slider,
                     layout = wibox.layout.flex.horizontal,
                     spacing = dpi(3),
                  },
                  layout = wibox.layout.fixed.horizontal,
               },
               left = dpi(7),
               right = dpi(7),
               layout = wibox.container.margin,
            },
            -- End section
            {
               {
                  widget = wibox.widget.systray
               },
               -- s.mylayoutbox,
               {
                  format = "%Y-%m-%d",
                  widget = wibox.widget.textclock
               },
               {
                  format = "%H:%M:%S",
                  widget = wibox.widget.textclock
               },
               helper.empty,
               spacing = dpi(10),
               spacing_widget = helper.sep,
               layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
         },
         layout = wibox.container.margin,
         bottom = dpi(1),
         color = beautiful.fg_normal,
      },
      top = dpi(0),
      layout = wibox.container.margin,
   }
end

awful.screen.connect_for_each_screen(create)
