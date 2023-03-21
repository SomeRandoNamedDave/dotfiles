local naughty = require('naughty')

client.connect_signal('mouse::enter', function(c)
    if client.focus ~= c then
        c:activate { context = 'mouse_enter', raise = false }
    end
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)
