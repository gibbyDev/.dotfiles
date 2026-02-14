#!/usr/bin/env bash

# -----------------------------
# CONFIGURATION
# -----------------------------
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
ROFI_CONFIG_DIR="$HOME/.config/rofi"
INDEX_FILE="/tmp/current_wallpaper_index"

# Collect wallpapers
WALLPAPERS=("${WALLPAPER_DIR}"/*)
TOTAL_WALLPAPERS=${#WALLPAPERS[@]}

# Load current index
if [[ -f "$INDEX_FILE" ]]; then
    CURRENT_INDEX=$(<"$INDEX_FILE")
else
    CURRENT_INDEX=0
fi

# -----------------------------
# HELPER FUNCTIONS
# -----------------------------

extract_rofi_colors() {
    awk '/^\* {/,/^}/' "$HOME/.cache/wal/colors-rofi-dark.rasi" > "$ROFI_CONFIG_DIR/colors.rasi"
}

copy_current_wallpaper() {
    local wallpaper="$1"
    local wallpaper_filename=$(basename "$wallpaper")
    cp "$wallpaper" "$ROFI_CONFIG_DIR/current_wallpaper.$(echo "$wallpaper_filename" | awk -F. '{print $NF}')"
}

set_wallpaper() {
    local wallpaper="${WALLPAPERS[$CURRENT_INDEX]}"
    echo "Setting wallpaper: $wallpaper"

    # Change wallpaper using swww
    swww img "$wallpaper" --transition-type random

    # Generate colors with pywal
    wal -i "$wallpaper"

    # Update Pywalfox Firefox theme
    pywalfox update

    # Copy Waybar color scheme
    cp "$HOME/.cache/wal/colors-waybar.css" "$WAYBAR_CONFIG_DIR/colors-waybar.css"
    cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/wlogout/colors-waybar.css"
    cp "$HOME/.cache/wal/colors-wal.vim" "$HOME/.config/nvim/colors-wal.vim"

    # Extract Rofi colors
    extract_rofi_colors

    # Copy current wallpaper for Rofi preview
    copy_current_wallpaper "$wallpaper"

    # Reload nvim colors if running
    if pgrep nvim > /dev/null; then
        nvim --server /tmp/nvim.pipe --remote-send '<Esc>:source $HOME/.cache/wal/colors-wal.vim<CR>'
    fi
}

next_wallpaper() {
    CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL_WALLPAPERS ))
    echo "$CURRENT_INDEX" > "$INDEX_FILE"
    set_wallpaper
}

prev_wallpaper() {
    CURRENT_INDEX=$(( (CURRENT_INDEX - 1 + TOTAL_WALLPAPERS) % TOTAL_WALLPAPERS ))
    echo "$CURRENT_INDEX" > "$INDEX_FILE"
    set_wallpaper
}
select_wallpaper_rofi() {
    local THUMB_DIR="$HOME/.cache/wallpaper-thumbs"

    local selected=$(
        for wp in "${WALLPAPERS[@]}"; do
            filename="$(basename "$wp")"
            name_no_ext="${filename%.*}"

            thumb=$(find "$THUMB_DIR" -maxdepth 1 -type f -name "${name_no_ext}_*.png" | head -n1)

            [[ -z "$thumb" ]] && thumb="$wp"

            # IMPORTANT: real null byte + icon metadata
            printf "%s\0icon\x1f%s\n" "$filename" "$thumb"
        done | rofi -dmenu -i -show-icons \
            -theme "$HOME/.config/rofi/wallpaper.rasi"
    )

    if [[ -n "$selected" ]]; then
        for i in "${!WALLPAPERS[@]}"; do
            if [[ "$(basename "${WALLPAPERS[$i]}")" == "$selected" ]]; then
                CURRENT_INDEX=$i
                echo "$CURRENT_INDEX" > "$INDEX_FILE"
                set_wallpaper
                break
            fi
        done
    fi
}

case "$1" in
    next)
        next_wallpaper
        ;;
    prev)
        prev_wallpaper
        ;;
    rofi)
        select_wallpaper_rofi
        ;;
    *)
        echo "Usage: $0 {next|prev|rofi}"
        ;;
esac

