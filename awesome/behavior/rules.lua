-- Rules for awesomewm clients

-- Imports
awful = require("awful")
gears = require("gears")

-- Code
awful.rules.rules = gears.table.join(
   awful.rules.rules,
   {
      -- Floating clients
      {
         rule_any = {
            name = {
               "Event Tester",  -- xev.
            },
         },

         properties = { floating = true },
      },
      
      -- Ignore size hints for most windows
      {
         rule_any = {
            class = {
               "URxvt",
               "Emacs",
               "Firefox",
            },
         },
         properties = { size_hints_honor = false }
      },
      
      -- Set Firefox to always map on the tag named "2" on screen 1
      {
         rule = { class = "Firefox" },
         properties = { screen = 1, tag = "2" }
      },
   }
)
