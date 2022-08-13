--  ____ ____ ____ ____ ____ ____ ____ ____
-- ||k |||e |||y |||s |||. |||l |||u |||a ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- Imports
local awful = require("awful")

-- Setup
_G.modkey = "Mod4"

-- Key bindings
awful.keyboard.append_global_keybindings(
   {
      -- Focus
      awful.key({ _G.modkey }, "space", function ()
           awful.layout.inc(1, awful.screen.focused())
      end),
      awful.key({ _G.modkey }, "Tab",   function ()
            if not client.focus.fullscreen then
               awful.client.focus.byidx(1)
            end
      end),
      awful.key({ _G.modkey }, "o",     function ()
            if not client.focus.fullscreen then
               awful.client.focus.byidx(1)
            end
      end),
      -- Layout
      awful.key({ _G.modkey }, "m", function ()
            local ln = awful.layout.getname()
            local c = mouse.current_client
            if c == nil then
               return
            end

            c.fullscreen = false
            if ln == "max" then
               awful.layout.inc(1)
               awful.layout.remove_default_layout(awful.layout.suit.max)
            else
               awful.layout.append_default_layout(awful.layout.suit.max)
               awful.layout.set(awful.layout.suit.max)
            end
      end),
      -- Directional focus
      awful.key({ _G.modkey }, "h", function () awful.client.focus.bydirection("left")  end),
      awful.key({ _G.modkey }, "j", function () awful.client.focus.bydirection("down")  end),
      awful.key({ _G.modkey }, "k", function () awful.client.focus.bydirection("up")    end),
      awful.key({ _G.modkey }, "l", function () awful.client.focus.bydirection("right") end),
      -- Directional swap
      awful.key({ _G.modkey }, "Left",  function () awful.client.swap.bydirection("left")  end),
      awful.key({ _G.modkey }, "Down",  function () awful.client.swap.bydirection("down")  end),
      awful.key({ _G.modkey }, "Up",    function () awful.client.swap.bydirection("up")    end),
      awful.key({ _G.modkey }, "Right", function () awful.client.swap.bydirection("right") end),
      -- Spawn apps
      awful.key({ _G.modkey }, "Return", function () awful.spawn(_G.terminal or "xterm") end),
      awful.key({ _G.modkey }, "d", function () awful.spawn("rofi -show drun") end),
      awful.key({ _G.modkey }, "F12", function ()
            awful.spawn("sh -c 'maim -us | xclip -selection clipboard -t image/png'")
      end),
      awful.key({ _G.modkey }, "F11", function ()
            awful.spawn("sh -c 'maim -us | tesseract - - | sed -z \"s/..$//\" | xclip -selection clipboard'")
      end),
      awful.key({ _G.modkey }, "F10", function ()
            awful.spawn("sh -c 'maim -us | zbarimg - | xclip -selection clipboard'")
      end),
      -- AwesomeWM
      awful.key({ _G.modkey }, "F9", awesome.restart),
   }
)

awful.keyboard.append_client_keybindings(
   {
      awful.key({ _G.modkey }, "x", function (self) self:kill() end),
      awful.key({ _G.modkey }, "f", function (self)
            self.fullscreen = not self.fullscreen;
            self:raise()
      end),
      awful.key({ _G.modkey }, "n", function (self)
            self.floating = not self.floating
            self:raise()
      end),
      awful.key({ _G.modkey }, "s", function (self) awful.placement.centered(self) end)
   }
)
