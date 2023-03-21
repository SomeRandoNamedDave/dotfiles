-- local alert = require('naughty').notification
local awful = require('awful')
local spawn = awful.spawn

local hotkeys_popup = require('awful.hotkeys_popup')
require('config.external_hotkeys')

local browser = [[ qutebrowser \
    --qt-flag ignore-gpu-blocklist \
    --qt-flag enable-gpu-rasterization \
    --qt-flag enable-native-gpu-memory-buffers \
    --qt-flag num-raster-threads=4 \
    --qt-flag enable-accelerated-video-decode \
    --qt-flag use-gl=desktop
]]

local picom = [[ picom -b \
    --experimental-backends \
    --animations \
    --animation-for-open-window zoom \
    --animation-window-mass 0.5 \
    --animation-stiffness 350
]]

-- awesome control keys
awful.keyboard.append_global_keybindings({ -- [ main ]
    awful.key(
        { 'Mod4' },
        'F1',
        hotkeys_popup.show_help,
        { description='--> show help', group='awesome: main' }
    ),
    awful.key(
        { 'Mod4' },
        'Escape',
        awesome.restart,
        { description = '--> reload awesome', group = 'awesome: main' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'q',
        awesome.quit,
        { description = '--> quit awesome', group = 'awesome: main' }
    ),
    awful.key(
        { 'Mod4' },
        'BackSpace',
        function()
            for _, c in ipairs(client.get()) do
                if c.class == 'companion' then
                    if c.active then
                        c.hidden = true
                        return
                    end
                    c.hidden = false
                    c:activate({})
                    return
                end
            end
            spawn([[wezterm start --class 'companion' --]])
        end,
        { description = '--> toggle companion terminal', group = 'awesome: main' }
    ),
    awful.key(
        { 'Mod4' },
        'Tab',
        function() spawn('rofi -theme clients -show window') end,
        { description = '--> show client list', group = 'awesome: main' }
    )
})

awful.keyboard.append_global_keybindings({ -- [ cycle ]
    awful.key(
        { 'Mod4' },
        'Left',
        awful.tag.viewprev,
        { description = '--> previous tag', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'h',
        awful.tag.viewprev,
        { description = '--> previous tag', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'Right',
        awful.tag.viewnext,
        { description = '--> next tag', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'l',
        awful.tag.viewnext,
        { description = '--> next tag', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'Up',
        function() awful.client.focus.byidx(-1) end,
        { description = '--> previous client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'k',
        function() awful.client.focus.byidx(-1) end,
        { description = '--> previous client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'Down',
        function() awful.client.focus.byidx(1) end,
        { description = '--> next client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4' },
        'j',
        function() awful.client.focus.byidx(1) end,
        { description = '--> next client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'Up',
        function() awful.client.swap.byidx(-1) end,
        { description = '--> swap with previous client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'k',
        function() awful.client.swap.byidx(-1) end,
        { description = '--> swap with previous client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'Down',
        function() awful.client.swap.byidx(1) end,
        { description = '--> swap with next client', group = 'awesome: cycle (by index)' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'j',
        function() awful.client.swap.byidx(1) end,
        { description = '--> swap with next client', group = 'awesome: cycle (by index)' }
    )
})

awful.keyboard.append_global_keybindings({ -- [ tag ]
    awful.key(
        { 'Mod4' },
        '`',
        awful.tag.history.restore,
        { description = '--> last tag', group = 'awesome: tag' }
    ),
    awful.key({
        modifiers   = { 'Mod4' },
        keygroup    = 'numrow',
        description = '--> only view tag',
        group       = 'awesome: tag',
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then tag:view_only() end
        end
    }),
    awful.key({
        modifiers   = { 'Mod4', 'Shift' },
        keygroup    = 'numrow',
        description = '--> move focused client to tag',
        group       = 'awesome: tag',
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }),
    awful.key({
        modifiers   = { 'Mod4', 'Control' },
        keygroup    = 'numrow',
        description = '--> toggle tag',
        group       = 'awesome: tag',
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }),
    awful.key({
        modifiers   = { 'Mod4', 'Control', 'Shift' },
        keygroup    = 'numrow',
        description = '--> toggle focused client on tag',
        group       = 'awesome: tag',
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:toggle_tag(tag) end
            end
        end
    })
})

client.connect_signal('request::default_keybindings', function() -- [ client ]
    awful.keyboard.append_client_keybindings({
        awful.key(
            { 'Mod4' },
            'q',
            function(c) c:kill() end,
            { description = '--> close client', group = 'awesome: client' }
        ),
        awful.key(
            { 'Mod4' },
            'f',
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = '--> toggle fullscreen', group = 'awesome: client' }
        ),
        awful.key(
            { 'Mod4', 'Control' },
            'space',
            awful.client.floating.toggle,
            { description = '--> toggle floating', group = 'awesome: client' }
        ),
        awful.key(
            { 'Mod4', 'Mod1' },
            'space',
            function(c) c:swap(awful.client.getmaster()) end,
            { description = '--> swap with master client', group = 'awesome: client' }
        )
    })
end)

awful.keyboard.append_global_keybindings({ -- [ client ]
    awful.key(
        { 'Mod4' },
        'u',
        awful.client.urgent.jumpto,
        { description = '--> jump to urgent client', group = 'awesome: client' }
    ),
    awful.key(
        { 'Mod4' },
        'space',
        function()
            require('config.utils.flash_focus').flashfocus(client.focus)
        end,
        { description = '--> flash focused client', group = 'awesome: client' }
    )
})

awful.keyboard.append_global_keybindings({ -- [ layout ]
    awful.key({ -- TODO: add notification of layout
        modifiers   = { 'Mod4' },
        keygroup    = 'numpad',
        description = '--> directly select layout',
        group       = 'awesome: layout',
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then t.layout = t.layouts[index] or t.layout end
        end
    }),
    awful.key(
        { 'Mod4', 'Shift' },
        'Left',
        function() awful.tag.incmwfact(-0.05) end,
        { description = '--> decrease master width', group = 'awesome: layout' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'h',
        function() awful.tag.incmwfact(-0.05) end,
        { description = '--> decrease master width', group = 'awesome: layout' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'Right',
        function() awful.tag.incmwfact(0.05) end,
        { description = '--> increase master width', group = 'awesome: layout' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'l',
        function() awful.tag.incmwfact(0.05) end,
        { description = '--> increase master width', group = 'awesome: layout' }
    ),
    awful.key( -- TODO: add notification of layout
        { 'Mod4', 'Shift' },
        'j',
        function() awful.layout.inc(1) end,
        { description = '--> next layout', group = 'awesome: layout' }
    ),
    awful.key( -- TODO: add notification of layout
        { 'Mod4', 'Shift' },
        'k',
        function() awful.layout.inc(-1) end,
        { description = '--> previous layout', group = 'awesome: layout' }
    )
})

client.connect_signal('request::default_mousebindings', function() -- [ mouse bindings ]
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate { context = 'mouse_click' }
        end),
        awful.button({ 'Mod4' }, 1, function(c)
            c:activate { context = 'mouse_click', action = 'mouse_move'  }
        end),
        awful.button({ 'Mod4' }, 3, function(c)
            c:activate { context = 'mouse_click', action = 'mouse_resize' }
        end)
    })
end)

awful.keyboard.append_global_keybindings({ -- [ launch keys ]
    awful.key(
        { 'Mod4' },
        'slash',
        function() spawn('rofi -theme launcher -show drun') end,
        { description = '--> show launcher', group = 'launch' }
    ),
    awful.key(
        { 'Mod4' },
        'Return',
        function() spawn('wezterm start --') end,
        { description = '--> wezterm (terminal)', group = 'launch' }
    ),
    awful.key(
        { 'Mod4', 'Mod1' },
        'Return',
        function() spawn(browser) end,
        { description = '--> qutebrowser (browser)', group = 'launch' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'Return',
        function() spawn('wezterm start -- lf') end,
        { description = '--> lf (file manager)', group = 'launch' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        'BackSpace',
        function() spawn('wezterm start -- btop') end,
        { description = '--> btop (system monitor)', group = 'launch' }
    ),
})

for n = 6,8,1 do -- [ audio mixer ]
    awful.keyboard.append_global_keybindings({
        awful.key(
            { 'Mod4', 'Mod1' },
            'F' .. n,
            function()
                for _, c in ipairs(client.get()) do
                    if c.class == 'volume' then
                        if c.active then
                            c.hidden = true
                            return
                        end
                        c.hidden = false
                        c:activate({})
                        return
                    end
                end
                spawn("wezterm start --class 'volume' -- pulsemixer")
            end,
            { description = '--> pulsemixer (audio mixer)', group = 'launch' }
        )
    })
end

awful.keyboard.append_global_keybindings({ -- [ system keys ]
    -- backlight
    awful.key(
        { 'Mod4' },
        'F4',
        function() spawn.with_shell('xbacklight -dec 5') end, -- TODO: add notification
        { description = '--> decrease backlight intensity by 5%', group = 'system: backlight' }
    ),
    awful.key(
        { 'Mod4' },
        'F5',
        function() spawn.with_shell('xbacklight -inc 5') end, -- TODO: add notification
        { description = '--> increase backlight intensity by 5%', group = 'system: backlight' }
    ),
    -- volume
    awful.key(
        { 'Mod4' },
        'F6',
        function() spawn.with_shell('pactl set-sink-mute @DEFAULT_SINK@ toggle') end, -- TODO: add notification
        { description = '--> toggle volume mute', group = 'system: volume' }
    ),
    awful.key(
        { 'Mod4' },
        'F7',
        function() spawn.with_shell('pactl set-sink-volume @DEFAULT_SINK@ -5%') end, -- TODO: add notification
        { description = '--> decrease volume by 5%', group = 'system: volume' }
    ),
    awful.key(
        { 'Mod4' },
        'F8',
        function() spawn.with_shell('pactl set-sink-volume @DEFAULT_SINK@ +5%') end, -- TODO: add notification
        { description = '--> increase volume by 5%', group = 'system: volume' }
    ),
    -- capture
    awful.key(
        { },
        'Print',
        function() spawn.with_shell([[ffmpeg -f x11grab -video_size 1920x1080 -i "$DISPLAY" -vframes 1 ~/images/capture/scrot_$(date '+%Y%m%d-%H%M%S').png]]) end,
        { description = '--> take a screenshot', group = 'system: capture' }
    ),
    -- theme
    awful.key(
        { 'Mod4' },
        't',
        function() require('config.utils.theme').theme_select(true) end,
        { description = '--> randomize theme', group = 'system: theme' }
    ),
    awful.key(
        { 'Mod4', 'Shift' },
        't',
        function() require('config.utils.theme').theme_select() end,
        { description = '--> select theme', group = 'system: theme' }
    ),
    awful.key(
        { 'Mod4' },
        'p',
        function()
            spawn.with_line_callback('pgrep -c picom', {
                exit = function(_, r)
                    if r ~= 0 then
                        spawn(picom)
                    else
                        spawn.with_shell('killall -q picom')
                    end
                end
            })
        end,
        { description = '--> toggle picom', group = 'system: compositor' }
    )
})

-- mpd keys
local mpc_cmd = 'mpc -q '
local mpc = {
    { k = 'F9',  m = 'toggle', d = 'toggle mpd playback' },
    { k = 'F10', m = 'stop',   d = 'stop mpd playback' },
    { k = 'F11', m = 'prev',   d = 'previous song' },
    { k = 'F12', m = 'next',   d = 'next song' }
}
for _, x in pairs(mpc) do
    awful.keyboard.append_global_keybindings({
        awful.key(
            { 'Mod4' },
            x.k,
            function() spawn.with_shell(mpc_cmd .. x.m) end,
            { description = '--> ' .. x.d, group = 'mpd' }
        )
    })
end
awful.keyboard.append_global_keybindings({
    awful.key(
        { 'Mod4', 'Shift' },
        'F11',
        function() spawn.with_shell(mpc_cmd .. 'seek 0') end,
        { description = '--> restart song', group = 'mpd' }
    ),
    awful.key(
        { 'Mod4' },
        'm',
        function() spawn('rinse') end,
        { description = '--> select a song', group = 'mpd' }
    )
})
