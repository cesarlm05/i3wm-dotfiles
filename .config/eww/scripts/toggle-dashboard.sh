#!/bin/bash
# Toggle del dashboard (performance_monitor) con guard de ping:
# si el daemon no responde, un "eww open" directo forkea un segundo daemon
# que roba el socket y deja la ventana huerfana en el daemon viejo
# (dashboard pegado que ya no se puede cerrar).
eww ping &>/dev/null || exit 1
eww open --no-daemonize --toggle performance_monitor
~/.config/eww/scripts/cal-nav.sh reset &
