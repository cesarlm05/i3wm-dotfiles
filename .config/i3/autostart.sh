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

# 6. Settings Daemon
pgrep -x xsettingsd > /dev/null || xsettingsd &

# 7. Widgets (Eww)
# Esperar a que el eww anterior muera del todo: si "eww daemon" corre mientras
# el viejo sigue vivo, hereda un daemon medio muerto y deja ventanas huerfanas
# -r sin Z: un eww zombie (defunct) no se puede matar y dejaba este loop
# girando para siempre, bloqueando el resto del autostart. Timeout por si acaso.
killall eww 2>/dev/null
for _ in $(seq 50); do
    pgrep -x -r D,I,R,S,T eww >/dev/null || break
    sleep 0.1
done
eww daemon
for _ in $(seq 50); do
    eww ping &>/dev/null && break
    sleep 0.1
done
eww open bar

# 8. Clipboard manager
pgrep -f /usr/bin/clipmenud >/dev/null || clipmenud &

# 9. Monitor Scripts
pkill -f fullscreen-monitor
python3 ~/.config/eww/scripts/fullscreen-monitor.py &

