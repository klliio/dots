#!/bin/bash
#
# USAGE ./player.sh [args] [length]
#  ./player.sh --combined 30
#
export LANG=C; LC_ALL=C

if ! command -v playerctl &> /dev/null; then
    echo "playerctl is not installed."
    exit 1
fi

get_spotify_song() {
  playerctl -p spotify metadata --format "{{ artist }} - {{ title }}" 2> /dev/null
}

get_mpd_song() {
	mpc -f %albumartist%\ -\ %title% | sed -n '1p' 2> /dev/null
}

get_firefox_video() {
	playerctl -p firefox metadata --format "{{ artist }} - {{ title }}" 2> /dev/null
}

mpris="`playerctl status`"
mpd="`mpc status %state%`"
if [ "$mpris" == "Playing" ] || [ "$mpd" == "playing" ] ; then
	if pgrep -x "spotify" > /dev/null; then
		title="$(get_spotify_song)"
		icon=" "
	elif pgrep -x "ncmpcpp" > /dev/null; then
		title="$(get_mpd_song)"
		icon="󰎆 "
	elif pgrep -x "firefox" > /dev/null; then
		title="$(get_firefox_video)"
		icon=" "
	fi

	case "$1" in
		--icon) song="$icon" ;;
		--title) song="$title" ;;
		--combined) song="$icon$title" ;;
		*) exit 1 ;;
	esac
else
	song="Nothing is playing"
fi

if [[ -n "$song" ]]; then
	if [ ! -z "$2" ]; then
		if [ ${#song} -gt "$2" ]; then
			song="${song:0:"$2"}..."
		fi
	fi

	echo "`sed 's/VEVO//g' <<< $song`"
fi
