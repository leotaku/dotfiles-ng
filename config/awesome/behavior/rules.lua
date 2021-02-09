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
               "Event Tester",
               "Color Picker",
            },
         },

         properties = { floating = true },
      },

      -- Ignore size hints for most windows
      {
         rule_any = {
            class = {
               "urxvt", "URxvt",
               "emacs", "Emacs",
            },
         },
         properties = { size_hints_honor = false }
      },
   }
)
