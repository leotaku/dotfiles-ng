--  ____ ____ ____ ____ ____ ____ ____ ____ 
-- ||k |||e |||y |||s |||. |||l |||u |||a ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- Imports
relief = require("lib.relief")

-- Code

-- Setup
modkey = "Mod4"

-- Helpers
local helpers = {}
function helpers.toggle_fullscreen(c)
   c.fullscreen = not c.fullscreen
   c:raise()
end

function helpers.toggle_max(c)
   c.maximized = not c.maximized
   c:raise()
end

function helpers.prompt()
   awful.screen.focused().mypromptbox:run()
end

function helpers.inc_layout(i)
   local s = awful.screen.focused()
   awful.layout.inc(i, s)
end

-- Key bindings
local globalkeys = relief.keys.bindkeys(
   {},
   -- Layout
   {"M-space", helpers.inc_layout, 1},
   -- Directional focus
   {"M-h", awful.client.focus.bydirection, "left"},
   {"M-j", awful.client.focus.bydirection, "down"},
   {"M-k", awful.client.focus.bydirection, "up"},
   {"M-l", awful.client.focus.bydirection, "right"},
   -- Directional swap
   {"M-Left",  awful.client.swap.bydirection, "left"},
   {"M-Down",  awful.client.swap.bydirection, "down"},
   {"M-Up",    awful.client.swap.bydirection, "up"},
   {"M-Right", awful.client.swap.bydirection, "right"},
   -- Focus
   {"M-Tab", awful.client.focus.byidx, 1},
   -- Spawn apps
   -- TODO: put environment variables in separate file
   {"M-Return", awful.spawn, "urxvtc -e tmux"},
   {"M-d", helpers.prompt},
   -- AwesomeWM
   {"F9", awesome.restart}
)

local clientkeys = relief.keys.bindkeys(
   {},
   {"M-x", relief.method2curry("kill"), "self"},
   {"M-f", helpers.toggle_max, "self"}
   -- {"M-f", helpers.toggle_fullscreen, "self"},
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

local clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Exports
return {
   globalkeys = globalkeys,
   clientbuttons = clientbuttons,
   clientkeys = clientkeys,
}
