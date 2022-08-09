local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local notif_wb = wibox {
   visible = true,
   ontop = false,
   screen = screen.primary,
   height = screen.primary.geometry.height - dpi(20),
   width = dpi(200),
   opacity = 1,
}
awful.placement.bottom_right(notif_wb)

local notif_list = wibox.layout.fixed.vertical()

notif_list:setup {
   nil,
   layout = wibox.layout.fixed.vertical,
}

notif_wb:setup {
   nil,
   notif_list,
   layout = wibox.layout.align.vertical,
}

local notif_timeout = gears.timer {
   timeout   = 3,
   call_now  = false,
   autostart = false,
   single_shot = true;
   callback  = function()
      notif_wb.ontop = false
   end
}

-- Handle notification icon
naughty.connect_signal(
   "request::icon",
   function(n, context, hints)
      -- Handle other contexts here
      if context ~= "app_icon" then return end

      -- Use XDG icon
      local path = menubar.utils.lookup_icon(hints.app_icon) or
         menubar.utils.lookup_icon(hints.app_icon:lower())

      if path then
         n.icon = path
      end
   end
)

-- Use XDG icon
naughty.connect_signal(
   "request::action_icon",
   function(a, context, hints)
      a.icon = menubar.utils.lookup_icon(hints.id)
   end
)

local function urgency_color(urgency)
   if urgency == "critical"  then
      return beautiful.bg_urgent
   else
      return beautiful.blue
   end
end

local function notif_box(title, message, urgency)
   return wibox.widget {
      {
         {
            {
               markup = "<b>" .. title .. "</b>",
               widget = wibox.widget.textbox,
            },
            {
               markup = message,
               widget = wibox.widget.textbox,
            },
            layout = wibox.layout.align.vertical,
         },
         margins = dpi(10),
         layout = wibox.container.margin,
      },
      color = urgency_color(urgency),
      left = dpi(5),
      layout = wibox.container.margin,
   }
end

naughty.connect_signal(
   "request::display",
   function(n)
      local box = notif_box(n.title, n.message, n.urgency)
      notif_list:insert(1, box)
      notif_wb.ontop = true
      notif_timeout:stop()
      notif_timeout:start()
   end
)
