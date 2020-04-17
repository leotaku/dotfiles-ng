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

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Variables set for theming notifications:
-- notification_font
theme.notification_bg = "#151718"
theme.notification_fg = "#D6D6D6"
theme.notification_border_color = "#151718"
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_icon_size = 200
theme.notification_max_height = 200
theme.notification_max_width = 400
theme.notification_min_height = 100
theme.notification_min_width = 400

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.titlebar_close_button_normal = theme_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_path .. "wallpaper.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_path.."default/layouts/fairhw.png"
theme.layout_fairv = theme_path.."default/layouts/fairvw.png"
theme.layout_floating  = theme_path.."default/layouts/floatingw.png"
theme.layout_magnifier = theme_path.."default/layouts/magnifierw.png"
theme.layout_max = theme_path.."default/layouts/maxw.png"
theme.layout_fullscreen = theme_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_path.."default/layouts/tileleftw.png"
theme.layout_tile = theme_path.."default/layouts/tilew.png"
theme.layout_tiletop = theme_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = theme_path.."default/layouts/spiralw.png"
theme.layout_dwindle = theme_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = theme_path.."default/layouts/cornernww.png"
theme.layout_cornerne = theme_path.."default/layouts/cornernew.png"
theme.layout_cornersw = theme_path.."default/layouts/cornersww.png"
theme.layout_cornerse = theme_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Exports
return theme
