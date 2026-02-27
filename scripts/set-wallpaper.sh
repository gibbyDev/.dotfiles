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
    if [[ -f "$HOME/.cache/wal/colors-rofi-dark.rasi" ]]; then
        awk '/^\* {/,/^}/' "$HOME/.cache/wal/colors-rofi-dark.rasi" > "$ROFI_CONFIG_DIR/colors.rasi" 2>/dev/null || true
    fi
}

update_hyprlock_colors() {
    # Extract colors from pywal JSON and update hyprlock config
    local colors_json="$HOME/.cache/wal/colors.json"
    
    if [[ -f "$colors_json" ]]; then
        # This function is called after set_wallpaper, which updates the symlink
        # Hyprlock will read the new wallpaper on next lock
        # Note: Colors in hyprlock.nix are set statically at build time
        # so they won't update dynamically - only the wallpaper updates
        :
    fi
}

copy_current_wallpaper() {
    local wallpaper="$1"
    local wallpaper_filename=$(basename "$wallpaper")
    local output_file="$ROFI_CONFIG_DIR/current_wallpaper.$(echo "$wallpaper_filename" | awk -F. '{print $NF}')"
    
    # Remove existing file if it's read-only
    if [[ -f "$output_file" ]]; then
        chmod u+w "$output_file" 2>/dev/null || true
    fi
    
    cp "$wallpaper" "$output_file" 2>/dev/null || true
}

set_wallpaper() {
    local wallpaper="${WALLPAPERS[$CURRENT_INDEX]}"
    echo "Setting wallpaper: $wallpaper"

    # Change wallpaper using swww
    swww img "$wallpaper" --transition-type random

    # Generate colors with pywal
    wal -i "$wallpaper"

    # Update Pywalfox Firefox theme (if firefox is running)
    if pgrep firefox > /dev/null; then
        pywalfox update
    fi

    # Copy Waybar color scheme
    cp "$HOME/.cache/wal/colors-waybar.css" "$WAYBAR_CONFIG_DIR/colors-waybar.css"
    cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/wlogout/colors-waybar.css"
    cp "$HOME/.cache/wal/colors-wal.vim" "$HOME/.config/nvim/colors-wal.vim"
    cp "$HOME/.cache/wal/colors.css" "$HOME/.config/wlogout/colors.css"

    # Extract Rofi colors
    extract_rofi_colors

    # Copy current wallpaper for Rofi preview
    copy_current_wallpaper "$wallpaper"
    
    # Symlink wallpaper for hyprlock
    ln -sf "$wallpaper" "$HOME/.cache/hyprlock_wallpaper"

    # Update hyprlock colors dynamically using hyprctl
    update_hyprlock_colors

    # Reload swaync to apply new colors (CSS is cached until service restarts)
    systemctl --user restart swaync.service 2>/dev/null || true

    # Reload waybar to apply new colors
    pkill -SIGUSR2 waybar 2>/dev/null || true

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

