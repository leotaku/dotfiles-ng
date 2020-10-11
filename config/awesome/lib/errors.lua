-- Error handling
-- This has been taken from the default rc.lua file provided by AwesomeWM

-- Imports
naughty = require("naughty")

-- Code

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
   }
end

-- Handle runtime errors after startup
_G.in_error = false

awesome.connect_signal(
   "debug::error",
   function (err)
      -- Make sure we don't go into an endless error loop
      if _G.in_error then return end
      _G.in_error = true

      naughty.notify {
         preset = naughty.config.presets.critical,
         title = "Oops, an error happened!",
         text = tostring(err)
      }
   end
)
