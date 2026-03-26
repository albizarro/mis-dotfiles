#!/usr/bin/env bash
# Installs custom wallpaper config into the sddm-astronaut-theme.
# Updates metadata.desktop to use the custom_wallpaper.conf.

THEME_DIR="/usr/share/sddm/themes/sddm-astronaut-theme"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $EUID -ne 0 ]]; then
    echo "Run as root: sudo $0"
    exit 1
fi

if [[ ! -d "$THEME_DIR" ]]; then
    echo "Error: sddm-astronaut-theme not found at $THEME_DIR"
    exit 1
fi

echo "Copying custom wallpaper..."
cp "$SCRIPT_DIR/Backgrounds/custom_wallpaper.png" "$THEME_DIR/Backgrounds/custom_wallpaper.png"

echo "Copying custom theme config..."
cp "$SCRIPT_DIR/Themes/custom_wallpaper.conf" "$THEME_DIR/Themes/custom_wallpaper.conf"

echo "Updating metadata.desktop to use custom_wallpaper.conf..."
sed -i 's|^ConfigFile=.*|ConfigFile=Themes/custom_wallpaper.conf|' "$THEME_DIR/metadata.desktop"

echo "Done. SDDM will use the custom wallpaper on next login."
