local sidebar = wibox {
   visible = true,
   ontop = false,
   widget = wibox.layout.align.vertical,
   ---
   height = screen[1].geometry.height - 33,
   width = 400,
}

local timeout = gears.timer {
   timeout   = 6,
   call_now  = false,
   autostart = false,
   single_shot = true;
   callback  = function()
      sidebar.ontop = false
   end
}

local placement = awful.placement.bottom_right
placement(sidebar)

local function get_color(urgency)
   if urgency == "critical"  then
      return beautiful.bg_urgent
   else
      return beautiful.green
   end
end

local function create_notification_item(n)
   return {
      {
         {
            wibox.widget.textbox("<b>"..n.title.."</b>"),
            wibox.widget.textbox(n.text),
            layout = wibox.layout.fixed.vertical
         },
         margins = dpi(10),
         layout = wibox.container.margin
      },
      color = get_color(n.urgency),
      left = dpi(5),
      layout = wibox.container.margin
   }
end

naughty.connect_signal(
   "request::display",
   function(n)
      local children = sidebar.widget:get_children()
      local item = create_notification_item(n)

      local l = wibox.layout.fixed.vertical()
      l:add(item)
      for i, child in ipairs(children) do
         l:add(child)
      end

      sidebar.widget = l
      sidebar.ontop = true
      timeout:start()
   end
)
