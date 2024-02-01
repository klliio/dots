#!/bin/sh

directory="$HOME/Images/"
option=$(find "$directory" | sed 's/\/\(.*\/\)*//;/^$/d;/^[0-9a-zA-Z]*$/d' | rofi -dmenu -i)

if [ "$option" = "" ]; then
	exit 1
else
	imv "$(find $directory | grep $option)"
fi
