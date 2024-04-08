#!/bin/sh

case "$1" in
    --installed) file="$HOME/.log/Packages/Recent-Installed-Packages.txt" ;;
    --removed) file="$HOME/.log/Packages/Recent-Removed-Packages.txt" ;;
    *) printf "Please specify (un)installed\n"
       return 0
       exit 0
       ;;
esac


keep=300
packages="$(tail -n$keep $file)"
printf "%s" "$packages" > $file
