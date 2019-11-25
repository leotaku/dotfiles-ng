-- Enable sloppy focus, so that focus follows mouse.

-- Imports

-- Code
client.connect_signal(
   "mouse::enter",
   function(c)
      c:emit_signal("request::activate", "mouse_enter", {raise = false})
   end
)
