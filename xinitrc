#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# run systemd as user instance
# /usr/lib/systemd/systemd --user &

# /usr/bin/xscreensaver -no-splash &
xautolock -time 10 -locker lock &
~/.bin/lightsOn.sh 120 &
xbmc-prevent-xscreensaver &

/usr/bin/VBoxClient-all

xrdb -merge ~/.Xresources
#syndaemon -t -k -i 2 -d &

xbindkeys &

nm-applet &

dunst &

redshift &

exec $1
# conky &
