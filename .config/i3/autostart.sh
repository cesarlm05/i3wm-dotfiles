#!/bin/bash
# Autostart script for i3

# 1. System Settings 
setxkbmap -layout "latam" &

# 2. Notification Daemon (harus duluan sebelum yang lain)
pgrep -x dunst > /dev/null || dunst &
sleep 0.3

# 3. Wallpaper
~/.fehbg &

# 4. Compositor 
killall -q picom compton xcompmgr
while pgrep -x picom >/dev/null || pgrep -x compton >/dev/null || pgrep -x xcompmgr >/dev/null; do
    sleep 0.1
done

if command -v picom &> /dev/null; then
    picom &
elif command -v compton &> /dev/null; then
    compton &
fi

# 5. Settings Daemon
pgrep -x xsettingsd > /dev/null || xsettingsd &

# 6. Clipboard manager
pgrep -f /usr/bin/clipmenud >/dev/null || clipmenud &

