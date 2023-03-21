local awful = require('awful')
local gears = require('gears')

awful.util.shell = 'sh'

gears.timer {
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = function()
        collectgarbage('step', 1024)
        collectgarbage('setpause', 110)
        collectgarbage('setstepmul', 1000)
    end
}

require('config.utils.flash_focus').enable()

-- TODO: figure out how to set this up properly through the permissions api
require('config.deprecated').auto_focus()
