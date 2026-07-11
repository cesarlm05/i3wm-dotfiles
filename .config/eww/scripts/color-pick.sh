#!/bin/bash
# Selector de color de pantalla: cierra el control center para no estorbar,
# captura un pixel con xcolor y copia el hex al portapapeles

eww close control_center_window 2>/dev/null
sleep 0.2

color=$(xcolor -f hex)
[ -z "$color" ] && exit 0  # cancelado con Escape

printf '%s' "$color" | xclip -selection clipboard
notify-send -h "string:frcolor:$color" "Color copiado" "$color"
