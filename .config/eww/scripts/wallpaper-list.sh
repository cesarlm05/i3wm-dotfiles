#!/bin/bash
# Lista los wallpapers de ~/Pictures/Wallpapers como JSON para el selector
# del dashboard, generando miniaturas cacheadas (mismo esquema que wpg-select.sh)

WALL_DIR="$HOME/Pictures/Wallpapers"
THUMB_DIR="$HOME/.cache/eww-wall-thumbs"
mkdir -p "$THUMB_DIR"

find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    2>/dev/null | sort | while IFS= read -r img; do
    hash=$(printf '%s' "$img" | md5sum | cut -d' ' -f1)
    thumb="$THUMB_DIR/$hash.jpg"
    if [ ! -s "$thumb" ]; then
        magick "$img" -resize 400x240^ -gravity center -extent 400x240 \
            -quality 85 -strip "$thumb" 2>/dev/null || thumb="$img"
    fi
    name=$(basename "$img")
    jq -n --arg p "$img" --arg t "$thumb" --arg n "${name%.*}" \
        '{path:$p,thumb:$t,name:$n}'
done | jq -s -c .
