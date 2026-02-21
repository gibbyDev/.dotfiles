#!/usr/bin/env bash
set -euo pipefail

bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
for ((i=0; i<${#bar}; i++)); do
  dict+=";s/$i/${bar:$i:1}/g"
done

RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
pidfile="$RUNTIME_DIR/waybar-cava.pid"
if [ -f "$pidfile" ]; then
  oldpid=$(cat "$pidfile" || true)
  if [ -n "$oldpid" ] && kill -0 "$oldpid" 2>/dev/null; then
    kill "$oldpid" 2>/dev/null || true
    sleep 0.1
  fi
fi
echo $$ > "$pidfile"

config_file=$(mktemp "$RUNTIME_DIR/waybar-cava.XXXXXX.conf")
cleanup() { rm -f "$config_file" "$pidfile"; }
trap cleanup EXIT INT TERM

cat >"$config_file" <<EOF
[general]
framerate = 30
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

exec cava -p "$config_file" | sed -u "$dict"
