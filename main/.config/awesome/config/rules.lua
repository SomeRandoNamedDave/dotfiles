local awful = require('awful')
local ruled = require('ruled')

ruled.client.connect_signal('request::rules', function()
    ruled.client.append_rule {
        id         = 'global',
        rule       = {},
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    ruled.client.append_rule {
        id = 'floating',
        rule_any = {
            class = { 'Sxiv', 'mood' },
            name = { 'Event Tester' }
        },
        properties = { floating = true, placement = awful.placement.centered }
    }

    ruled.client.append_rule {
        id = 'scratchpad',
        rule_any = { class = { 'companion', 'rinse', 'volume' }},
        properties = { floating = true, placement = awful.placement.centered, sticky = true }
    }
end)

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule = {},
        properties = { screen = awful.screen.preferred, implicit_timeout = 5 }
    }
end)
