#!/bin/bash
# Cambia la ciudad del clima: geocodifica el nombre con Open-Meteo,
# actualiza weather.sh (unica fuente de verdad) y refresca los widgets

CITY_QUERY="$1"
WEATHER_SCRIPT="$HOME/.config/eww/scripts/weather.sh"

[ -z "$CITY_QUERY" ] && exit 1

RES=$(curl -sf -G "https://geocoding-api.open-meteo.com/v1/search" \
    --data-urlencode "name=$CITY_QUERY" \
    --data-urlencode "count=1" \
    --data-urlencode "format=json")

if [ -z "$RES" ] || [ "$(echo "$RES" | jq -r '.results | length // 0')" = "0" ]; then
    notify-send -u critical "Clima" "Ciudad no encontrada: $CITY_QUERY"
    exit 1
fi

NAME=$(echo "$RES" | jq -r '.results[0].name')
COUNTRY=$(echo "$RES" | jq -r '.results[0].country_code')
LAT=$(echo "$RES" | jq -r '.results[0].latitude')
LON=$(echo "$RES" | jq -r '.results[0].longitude')

# Sin comillas simples en el nombre para no romper weather.sh
NAME=${NAME//\'/}

sed -i \
    -e "s|^CITY_NAME=.*|CITY_NAME='$NAME'|" \
    -e "s|^COUNTRY_CODE=.*|COUNTRY_CODE='$COUNTRY'|" \
    -e "s|^LATITUDE=.*|LATITUDE=\"$LAT\"  # City latitude|" \
    -e "s|^LONGITUDE=.*|LONGITUDE=\"$LON\"  # City longitude|" \
    "$WEATHER_SCRIPT"

# Invalidar cache y refrescar todas las variables del clima
rm -rf ~/.cache/eww-weather ~/.cache/eww-weather-forecast
eww poll WEATHER_ICON WEATHER_DESC WEATHER_CITY WEATHER_TEMP \
         WEATHER_LAT WEATHER_LONG weather_forecast_data 2>/dev/null

notify-send "Clima" "Ciudad: $NAME, $COUNTRY ($LAT, $LON)"
