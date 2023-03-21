#!/bin/sh

active=false
while ! $active; do
    muted="$(pactl get-sink-mute @DEFAULT_SINK@)" 2>/dev/null
    [ -z "$muted" ] || active=true
done
muted=${muted##* }
[ $muted = 'no' ] && pactl set-sink-mute @DEFAULT_SINK@ 0
