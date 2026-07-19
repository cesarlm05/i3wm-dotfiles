#!/bin/bash
# Vacia el historial de clipmenu (y el portapapeles actual) con confirmacion

choice=$(printf "Vaciar\nCancelar" | rofi -dmenu \
    -p "Portapapeles" \
    -mesg "¿Vaciar el portapapeles?" \
    -theme ~/.config/rofi/confirm.rasi)

[ "$choice" = "Vaciar" ] || exit 0

clipdel -d '.*' >/dev/null 2>&1
printf '' | xclip -selection clipboard
notify-send "Portapapeles" "Historial vaciado"
