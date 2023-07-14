-- Rules for awesomewm clients

-- Imports
local ruled = require("ruled")

-- Code
ruled.client.append_rules {
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
   -- Force some applications to tile
   {
      rule_any = {
         class = {
            "firefox-aurora", "firefox", "Firefox",
            "blender", "Blender",
            "chromium-browser", "Chromium-browser",
            "inkscape", "Inkscape",
            "libreoffice",
         },
      },
      properties = { maximized = false, floating = false },
   },
   -- Ignore size hints for most windows
   {
      rule_any = {
        class = {
            "kitty", "Kitty",
            "emacs", "Emacs",
         },
      },
      properties = { size_hints_honor = false },
   },
}
