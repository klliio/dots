#!/bin/sh

directory="$HOME/Videos/"
option=$(find "$directory" | sed 's/\/\(.*\/\)*//;/^$/d;/^[0-9a-zA-Z]*$/d' | rofi -dmenu -i)

if [ "$option" = "" ]; then
	exit 1
else
	mpv "$(find "$directory" | grep "$option")"
fi
