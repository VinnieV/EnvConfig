#!/bin/bash
scrot /tmp/lockscreen.png
convert /tmp/lockscreen.png -scale 10% -scale 1000% /tmp/lockscreen.png
[[ -f $1 ]] && convert /tmp/lockscreen.png $1 -gravity center -composite -matte /tmp/lockscreen.png
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -u -i /tmp/lockscreen.png
rm /tmp/lockscreen.png
