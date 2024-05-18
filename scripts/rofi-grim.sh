#!/bin/sh
#
# Dependencies:
# 	- slurp
# 	- grim
# 	- rofi
# 	- wayland
# 	- a notification daemon
#

time="$(date +%Y-%m-%dT%H-%M-%S%z)"
scrshotDir="$HOME/Images/Screenshots/"
if [ "$1" = --quick ]; then
    grim "$scrshotDir$time.png"
    notify-send -a rofi-grim -i "$scrshotDir$time.png" "Screenshot" "Saved as $time.png"
else
    # Take a screenshot using grim command and save it with a temporary file name
    tmp_file=$(mktemp /tmp/screenshot_XXXXXX.png)

    selection=$(printf "Fullscreen\nRegion" | rofi -dmenu -p "Selection type")
    case "$selection" in
        "Region") 
            # use slurp to get the selection area
            grim -g "$(slurp)" -t jpeg -q 100 "$tmp_file"
            ;;
        "Fullscreen") grim -t jpeg -q 100 "$tmp_file" ;;
        *) exit 1 ;;
    esac

    while true; do
        # Use Rofi prompt to ask for a file name
        file_name=$(ls "$scrshotDir" | sed -E 's/\.[a-zA-Z]*//' | rofi -dmenu -p "Enter file name")
        # Check if a file name was entered
        if [ -z "$file_name" ]; then
            notify-send -a rofi-grim Screenshot "No file name entered. Aborting."
            exit 1
        fi
        
        if [ -f "$scrshotDir""$file_name".png ]; then
            choice=$(printf "Rename\nReplace\nKeep & ignore" | rofi -dmenu -p "File with the same name exists!")
        
            case "$choice" in
                "Rename")
                    continue
                    ;;
                "Replace")
                    mv "$tmp_file" "$scrshotDir$file_name.png"
                    notify-send -a rofi-grim -i "$scrshotDir$file_name.png" Screenshot "Replaced the existing picture."
                    break
                    ;;
                "Keep & ignore")
                    rm "$tmp_file"
                    notify-send -a rofi-grim -i "$scrshotDir$file_name.png" Screenshot "Discarded. Existing picture kept."
                    break
                    ;;
                *)
                    notify-send -a rofi-grim Screenshot "Invalid choice or no action taken. Aborting."
                    rm "$tmp_file"
                    exit 1
                    ;;
            esac
        else
            mv "$tmp_file" "$scrshotDir$file_name.png"
            notify-send -a rofi-grim -i "$scrshotDir$file_name.png" Screenshot "Saved as $file_name.png"
            break
        fi
    done
fi
