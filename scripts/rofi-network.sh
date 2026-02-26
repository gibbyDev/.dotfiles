#!/usr/bin/env bash

# Simple rofi-based WiFi network manager with pywal color support

# Get available WiFi networks
networks=$(nmcli --fields SSID,SIGNAL device wifi list --rescan yes 2>/dev/null | tail -n +2 | awk '
{
    ssid = $1
    signal = $2
    if (ssid == "") next
    
    # Skip duplicates
    if (seen[ssid]) next
    seen[ssid] = 1
    
    # Signal strength icons
    if (signal >= 75) icon = "󰤾"
    else if (signal >= 50) icon = "󰤿"
    else if (signal >= 25) icon = "󰤽"
    else icon = "󰤼"
    
    printf "%s %s (%d%%)\n", icon, ssid, signal
}' | sort -u)

# Add action options at the top
menu="📶 Refresh Networks
🔆 Enable WiFi
🔅 Disable WiFi
---
$networks"

# Show rofi menu with network theme
selected=$(echo "$menu" | rofi -dmenu -theme network -p "WiFi" 2>/dev/null)

[[ -z "$selected" ]] && exit 0

case "$selected" in
    "📶 Refresh Networks")
        bash "$0"
        ;;
    "🔆 Enable WiFi")
        nmcli radio wifi on
        notify-send "WiFi" "WiFi enabled" 2>/dev/null
        ;;
    "🔅 Disable WiFi")
        nmcli radio wifi off
        notify-send "WiFi" "WiFi disabled" 2>/dev/null
        ;;
    "---")
        ;;
    *)
        # Extract SSID from selection (remove icon and signal strength)
        ssid=$(echo "$selected" | sed 's/^[^ ]* \(.*\) ([0-9]*%)$/\1/')
        
        # Try to connect
        if nmcli connection show | grep -q "^$ssid"; then
            # Already saved connection
            nmcli connection up "$ssid" 2>/dev/null && \
                notify-send "WiFi" "Connected to $ssid" 2>/dev/null || \
                notify-send "WiFi" "Failed to connect to $ssid" 2>/dev/null
        else
            # Need password
            password=$(rofi -dmenu -password -theme network \
                -p "Password for $ssid" 2>/dev/null)
            if [[ -n "$password" ]]; then
                nmcli device wifi connect "$ssid" password "$password" 2>/dev/null && \
                    notify-send "WiFi" "Connected to $ssid" 2>/dev/null || \
                    notify-send "WiFi" "Failed to connect to $ssid" 2>/dev/null
            fi
        fi
        ;;
esac
