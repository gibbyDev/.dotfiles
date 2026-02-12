# #!/usr/bin/env bash
#
# # Move floating window or fallback to tiling move
# direction=$1
# amount=${2:-10}
#
# # normalize direction to the single-letter hyprctl form
# case "${direction,,}" in
#   left|l) dir=l ;;
#   right|r) dir=r ;;
#   up|u|top|t) dir=u ;;
#   down|d|bottom|b) dir=d ;;
#   *)
#     echo "Usage: move-floating.sh <left|right|up|down|l|r|u|d> [amount]"
#     exit 1
#     ;;
# esac
#
# # ensure dependencies
# if ! command -v hyprctl >/dev/null 2>&1; then
#   echo "hyprctl not found in PATH" >&2
#   exit 1
# fi
# if ! command -v jq >/dev/null 2>&1; then
#   echo "jq not found in PATH" >&2
#   exit 1
# fi
#
# if hyprctl activewindow -j | jq -r .floating | grep -q true; then
#   hyprctl dispatch moveactive "$dir" "$amount"
# else
#   hyprctl dispatch movewindow "$dir"
# fi
#
#!/usr/bin/env sh
# move_floating.sh

STEP=50
case "$1" in
  l)
    hyprctl dispatch moveactive -50 0
    ;;
  r)
    hyprctl dispatch moveactive 50 0
    ;;
  u)
    hyprctl dispatch moveactive 0 -50
    ;;
  d)
    hyprctl dispatch moveactive 0 50
    ;;
  *)
    echo "Usage: $0 {left|right|up|down}"
    exit 1
    ;;
esac

