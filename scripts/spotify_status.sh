#!/usr/bin/env bash

STATUS=$(playerctl --player=spotify status)
[[ "${STATUS}" != "Playing" ]] && exit 0

ALBUM=$(playerctl --player=spotify metadata album)
ARTIST=$(playerctl --player=spotify metadata artist)
SONG=$(playerctl --player=spotify metadata title)

echo " ♬ ${SONG} - ${ARTIST} "
exit 0
