--       .
--  .>   )\;`a__
-- (  _ _)/ /-." ~~
--  `( )_ )/
--   <_  <_ theme.lua

-- Art by Donovan Bake

-- Imports
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_path = gfs.get_configuration_dir() .. "/theming/automata/"

-- Code
local theme = {}

theme.color0        = "#151718"
theme.color8        = "#657b83"
theme.color1        = "#dc322f"
theme.color9        = "#bc120f"
theme.color2        = "#859900"
theme.color10       = "#657900"
theme.color3        = "#b58900"
theme.color11       = "#a57900"
theme.color4        = "#268bd2"
theme.color12       = "#167bc2"
theme.color5        = "#6c71c4"
theme.color13       = "#5c61b4"
theme.color6        = "#2aa198"
theme.color14       = "#1b9289"
theme.color7        = "#93a1a1"
theme.color15       = "#FFFFFF"

theme.black         = theme.color0
theme.red           = theme.color1
theme.green         = theme.color2
theme.yellow        = theme.color3
theme.blue          = theme.color4
theme.magenta       = theme.color5
theme.cyan          = theme.color6
theme.lightgray     = theme.color7
theme.gray          = theme.color8
theme.darkred       = theme.color9
theme.darkgreen     = theme.color10
theme.darkyellow    = theme.color11
theme.darkblue      = theme.color12
theme.darkmagenta   = theme.color13
theme.darkcyan      = theme.color14
theme.white         = theme.color15

theme.font          = "Fira Mono 9"

theme.bg_normal     = theme.black
theme.bg_focus      = theme.white
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.black
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.white
theme.fg_focus      = theme.black
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = theme.white
theme.border_focus  = theme.magenta
theme.border_marked = theme.blue

-- There are other variable sets overriding the default one when
-- defined, the sets are:

-- theme.taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- theme.tasklist_[bg|fg]_[focus|urgent]
-- theme.titlebar_[bg|fg]_[normal|focus]
-- theme.tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- theme.mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- theme.prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- theme.hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Variables set for theming notifications:
-- theme.notification_font
theme.notification_bg = "#151718"
theme.notification_fg = "#D6D6D6"
theme.notification_border_color = "#151718"
-- theme.notification_[width|height|margin]
-- theme.notification_[border_color|border_width|shape|opacity]
theme.notification_icon_size = 200
theme.notification_max_height = 200
theme.notification_max_width = 400
theme.notification_min_height = 100
theme.notification_min_width = 400

-- Variables set for theming the menu:
-- theme.menu_[bg|fg]_[normal|focus]
-- theme.menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Exports
return theme
