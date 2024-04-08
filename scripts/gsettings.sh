#!/bin/sh

gnomeschema=org.gnome.desktop.interface
gsettings set "$gnomeschema" cursor-theme Breeze_Obsidian
gsettings set "$gnomeschema" gtk-theme "Catppuccin-mauve"
gsettings set "$gnomeschema" font-name "UbuntuMono 11"

export XCURSOR_PATH=${XCURSOR_PATH}:/usr/share/icons/
export XCURSOR_THEME=Breeze_Obsidian
export XCURSOR_SIZE=30
