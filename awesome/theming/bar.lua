--    _____________,-.___     _
--   |____        { {]_]_]   [_]
--   |___ `-----.__\ \_]_]_    . `
--   |   `-----.____} }]_]_]_   ,
--   |_____________/ {_]_]_]_] , `
-- bar.lua         `-'

-- Art by Hayley Jane Wakenshaw

-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local utils = require("lib.utils")

-- Local
local dpi = beautiful.xresources.apply_dpi
local read_file = utils.read_file

-- Code
local helper = {
   sep = wibox.widget {
      {
         layout = wibox.container.margin,
         left = dpi(1),
      },
      {
         markup = "|",
         widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal
   }
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

local function create_progress(arg)
   return wibox.widget {
      {
         id = "progress",
         shape = gears.shape.rounded_rect,
         max_value = arg.maximum,
         value = arg.value,
         widget = wibox.widget.progressbar,
         color = arg.color,
         background_color = arg.background_color,
      },
      top = dpi(7),
      bottom = dpi(7),
      layout = wibox.container.margin,
      set_value = function(self, val)
        self.progress.value = val
      end
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

local battery_slider = create_progress {
   color = beautiful.darkgreen,
   background_color = beautiful.green,
   value = 0,
   maximum = 1000,
   minimum = 0,
}

local calendar = wibox.widget {
   date = os.date('*t'),
   widget = wibox.widget.calendar.month,
}

local calendar_widget = wibox.widget {
   {
      calendar,
      top = dpi(5),
      bottom = dpi(5),
      left = dpi(10),
      right = dpi(10),
      layout = wibox.container.margin
   },
   color = beautiful.white,
   top = dpi(1),
   layout = wibox.container.margin
}

gears.timer {
    timeout   = 60,
    call_now  = true,
    autostart = true,
    callback  = function()
       calendar.date = os.date('*t')
    end
}

gears.timer {
    timeout   = 10,
    call_now  = true,
    autostart = true,
    callback  = function()
       now = tonumber(read_file("/sys/class/power_supply/BAT0/energy_now"))
       full = tonumber(read_file("/sys/class/power_supply/BAT0/energy_full"))

       battery_slider.value = math.floor(1000 * now/full)
    end
}

local function create(s)
   local mypromptbox = awful.widget.prompt {
      prompt = 'Execute: '
   }
   local mylayoutbox = awful.widget.layoutbox(s)
   local mytaglist = awful.widget.taglist {
      screen = s,
      filter  = awful.widget.taglist.filter.all,
      layout   = {
         spacing = dpi(7),
         --spacing_widget = helper.sep,
         layout  = wibox.layout.fixed.horizontal,
      },
   }
   
   local mytextclock = wibox.widget.textclock("%H:%M")

   local cal_popup = awful.popup {
      ontop = true,
      visible = false,
      preferred_positions = top,
      widget = calendar_widget
   }
   awful.placement.top_right(
      cal_popup,
      {
         margins = { top = dpi(22), right = 0},
         parent = awful.screen.focused()
      }
   )
   mytextclock:connect_signal(
      "mouse::enter",
      function ()
         awful.placement.top_right(
            cal_popup,
            {
               margins = { top = dpi(22), right = 0},
               parent = awful.screen.focused()
            }
         )
         cal_popup.visible = true
      end
   )
   mytextclock:connect_signal(
      "mouse::leave",
      function ()
         cal_popup.visible = false
      end
   )

   local mymail = wibox.widget {
      awful.widget.watch('notmuch count tag:unread', 5),
      wibox.widget.textbox('Mail'),
      spacing = dpi(3),
      layout = wibox.layout.fixed.horizontal,
   };
   -- local mymailmessages = wibox.widget {};
   -- mymailmessages:attach( mymail, "tr" )
   
   local top_bar = awful.wibar(
      {
         position = "top",
         screen = s,
         width = s.geometry.width,
         -- height = dpi(27),
         bg = beautiful.black,
      }
   )
   
   top_bar:setup {
      {
         -- Actual bar
         {
            -- Start section
            {
               {
                  mytaglist,
                  left = dpi(5),
                  layout = wibox.container.margin,
               },
               {
                  mypromptbox,
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
               mybattery,
               {
                  {
                     widget = wibox.widget.systray
                  },
                  top = dpi(3),
                  bottom = dpi(3),
                  layout = wibox.container.margin
               },
               mytextclock,
               mymail,
               spacing = dpi(10),
               spacing_widget = helper.sep,
               layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
         },
         layout = wibox.container.margin,
         bottom = dpi(0),
         color = beautiful.black,
      },
      top = dpi(0),
      layout = wibox.container.margin,
   }
end

awful.screen.connect_for_each_screen(create)
