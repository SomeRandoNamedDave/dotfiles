function sstgl --description 'toggle screensaver'
    xset -q | string match -rq "DPMS is Enabled"
    if test $status -ne 0
        xset s on; xset +dpms
        echo "screensaver now enabled"
    else
        xset s off; xset -dpms
        echo "screensaver now disabled"
    end
end
