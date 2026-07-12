#!/bin/bash
# Calendario del popup/dashboard sin el widget GTK (crashea la ventana al
# cambiar de mes en eww). Genera la cuadricula como JSON y la renderizan
# labels puros. El mes/año mostrado vive en un archivo de estado.

STATE="$HOME/.cache/eww-cal-state"

case "$1" in
    reset)
        M=$(date +%-m); Y=$(date +%Y)
        ;;
    next|prev)
        if [ -f "$STATE" ]; then
            read -r M Y < "$STATE"
        else
            M=$(date +%-m); Y=$(date +%Y)
        fi
        if [ "$1" = "next" ]; then
            M=$((M + 1)); [ "$M" -gt 12 ] && { M=1; Y=$((Y + 1)); }
        else
            M=$((M - 1)); [ "$M" -lt 1 ] && { M=12; Y=$((Y - 1)); }
        fi
        ;;
    *) exit 1 ;;
esac

echo "$M $Y" > "$STATE"

NAME=$(date -d "$Y-$(printf '%02d' "$M")-01" +%B)

DATA=$(python3 - "$M" "$Y" "$NAME" <<'PY'
import calendar, json, sys
from datetime import date

m, y, name = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
today = date.today()
cal = calendar.Calendar(firstweekday=6)  # semana empieza en domingo

weeks = []
for week in cal.monthdatescalendar(y, m):
    weeks.append([
        {
            "d": d.day,
            "cur": d.month == m and d.year == y,
            "today": d == today,
        }
        for d in week
    ])

print(json.dumps({
    "month_name": name,
    "year": y,
    "dows": ["dom", "lun", "mar", "mié", "jue", "vie", "sáb"],
    "weeks": weeks,
}, ensure_ascii=False))
PY
)

eww update cal_data="$DATA"
