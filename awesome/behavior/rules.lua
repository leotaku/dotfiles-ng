-- Rules for awesomewm clients

-- Imports
awful = require("awful")
gears = require("gears")

-- Code
awful.rules.rules = gears.table.join(
   awful.rules.rules,
   {
      -- Center all floating clients
      {
         rule_any = {
            name = {
               "Event Tester",  -- xev.
            },
         },

         properties = { floating = true },
      },
      
      -- Add titlebars to normal clients and dialogs
      {
         rule_any = {
            type = { "normal", "dialog" }
         },
         properties = {
            titlebars_enabled = true
         },
         callback = function (c)
            awful.placement.centered(c, { parent = mouse.current_client or mouse.current_screen })
         end,
      },

      -- Ignore size hints for terminals.
      {
         rule = { class = "URxvt" },
         properties = { size_hints_honor = false }
      },
      
      -- Set Firefox to always map on the tag named "2" on screen 1.
      {
         rule = { class = "Firefox" },
         properties = { screen = 1, tag = "2" }
      },
   }
)
