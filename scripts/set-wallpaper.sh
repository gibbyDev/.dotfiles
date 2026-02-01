# #!/usr/bin/env bash
#
# WALLPAPER_DIR="$HOME/Pictures/wallpapers"
# WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
# ROFI_CONFIG_DIR="$HOME/.config/rofi"
# INDEX_FILE="/tmp/current_wallpaper_index"
#
# WALLPAPERS=("${WALLPAPER_DIR}"/*)
# TOTAL_WALLPAPERS=${#WALLPAPERS[@]}
#
# if [[ -f "$INDEX_FILE" ]]; then
#     CURRENT_INDEX=$(<"$INDEX_FILE")
# else
#     CURRENT_INDEX=0
# fi
#
# extract_rofi_colors() {
#     awk '/^\* {/,/^}/' "$HOME/.cache/wal/colors-rofi-dark.rasi" > "$ROFI_CONFIG_DIR/colors.rasi"
# }
#
# copy_current_wallpaper() {
#     local wallpaper="$1"
#     local wallpaper_filename=$(basename "$wallpaper")
#     cp "$wallpaper" "$ROFI_CONFIG_DIR/current_wallpaper.$(echo "$wallpaper_filename" | awk -F. '{print $NF}')"
# }
#
# set_wallpaper() {
#     local wallpaper="${WALLPAPERS[$CURRENT_INDEX]}"
#     echo "Setting wallpaper: $wallpaper"
#
#     # Change wallpaper
#     swww img "$wallpaper" --transition-type random
#
#     # Generate colors and apply them using pywal
#     wal -i "$wallpaper"
#
#     # Update Pywalfox Firefox theme
#     pywalfox update
#
#     # Copy the generated Waybar color scheme
#     cp "$HOME/.cache/wal/colors-waybar.css" "$WAYBAR_CONFIG_DIR/colors-waybar.css"
#
#     cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/wlogout/colors-waybar.css"
#
#     cp "$HOME/.cache/wal/colors-wal.vim" "$HOME/.config/nvim/colors-wal.vim"
#
#     # Extract only the color variables from the rofi file
#     extract_rofi_colors
#
#     # Copy the current wallpaper to rofi config dir
#     copy_current_wallpaper "$wallpaper"
#
#     # Restart Waybar
#     # if pgrep waybar > /dev/null; then
#     #     pkill waybar
#     # fi
#     # waybar &
#     #
#     if pgrep nvim > /dev/null; then
#         nvim --server /tmp/nvim.pipe --remote-send '<Esc>:source $HOME/.cache/wal/colors-wal.vim<CR>'
#     fi
#
# }
#
# next_wallpaper() {
#     CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL_WALLPAPERS ))
#     echo "$CURRENT_INDEX" > "$INDEX_FILE"
#     set_wallpaper
# }
#
# prev_wallpaper() {
#     CURRENT_INDEX=$(( (CURRENT_INDEX - 1 + TOTAL_WALLPAPERS) % TOTAL_WALLPAPERS ))
#     echo "$CURRENT_INDEX" > "$INDEX_FILE"
#     set_wallpaper
# }
#
# case "$1" in
#     next)
#         next_wallpaper
#         ;;
#     prev)
#         prev_wallpaper
#         ;;
#     *)
#         echo "Usage: $0 {next|prev}"
#         ;;
# esac
#
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

# -----------------------------
# ROFI THUMBNAIL SELECTION
# -----------------------------
select_wallpaper_rofi() {
    # Create a temporary file for Rofi entries
    TMPFILE=$(mktemp)
    for wp in "${WALLPAPERS[@]}"; do
        echo "$wp" >> "$TMPFILE"
    done

    # Rofi command with image preview using 'chafa'
    # chafa converts images to ASCII/Unicode for terminal preview
    local selected=$(rofi -dmenu -i -p "Select Wallpaper" -theme "$ROFI_CONFIG_DIR/user.rasi" \
        -format i -markup-rows -eh 2 -lines ${TOTAL_WALLPAPERS} \
        -mesg "Use arrow keys, Enter to select" \
        -custom-widget "preview:rofi-wallpaper-preview.sh" \
        < "$TMPFILE")

    rm -f "$TMPFILE"

    if [[ -n "$selected" ]]; then
        # Selected is index
        CURRENT_INDEX=$selected
        echo "$CURRENT_INDEX" > "$INDEX_FILE"
        set_wallpaper
    fi
}

