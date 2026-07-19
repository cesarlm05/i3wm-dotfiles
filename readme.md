# Simple Auto-Ricing i3wm Dotfiles

<div align="center">

**Minimal i3wm with automated Material 3 theming from wallpapers**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?logo=arch-linux&logoColor=fff)](https://archlinux.org/)
[![i3wm](https://img.shields.io/badge/WM-i3-orange)](https://i3wm.org/)

</div>

---

> [!NOTE]
> **Eww removed**
>
> This project used to ship **[Eww](https://github.com/elkowar/eww)** as its bar/widget framework.
> Eww was effectively abandoned upstream (no meaningful updates in years, accumulated bugs with no
> fixes), so it was dropped entirely — no bar, popups, start menu, or control center for now.
> i3 runs bare. A lighter replacement may be added later.

---

## DEMO VIDEO

https://github.com/user-attachments/assets/f52d2bca-540a-45a8-8b81-4ce3fa77b193

---

## Screenshots

**Clean Desktop**

![Clean Desktop](./Screenshot/clean-1.png)

**Minimalist Desktop**

![Rofi Launcher](./Screenshot/minimal-1.png)

**Daily Desktop**

![Daily Desktop](./Screenshot/aurora-1.png)

**Colorful Desktop**

![Colorful Desktop](./Screenshot/field.png)

**Wonderful Desktop**

![Wonderful Desktop](./Screenshot/bali-1.png)

---

## Features

- **Auto Material 3 Theming** - Colors extracted from wallpapers via m3wal
- **Lightweight** - Minimal resources, fast performance
- **Complete Setup** - i3wm, Alacritty, Fish, Rofi, all themed
- **One-Click Install** - Automated with backup
- **Universal Hardware Detection** - WiFi, battery, AC adapter auto-detected via glob patterns, works with any naming convention

---

## Stack

| Component     | App       |
| :------------ | :-------- |
| WM            | i3-wm     |
| Bar           | None (eww removed) |
| Theming       | m3wal     |
| Compositor    | Picom     |
| Terminal      | Alacritty |
| Shell         | Fish      |
| Launcher      | Rofi      |
| Notifications | Dunst     |

---

## Installation

```bash
git clone https://github.com/MDiaznf23/simple-autoricing-i3wm-dotfiles.git
cd simple-autoricing-i3wm-dotfiles
chmod +x install.sh
./install.sh
```

**Script will:**

- Install all packages (repos + AUR)
- Backup existing configs to `~/dotfiles_backup_YYYYMMDD_HHMMSS`
- Install yay if needed
- Install m3wal via aur (you can use pipx if you want)
- Copy all dotfiles
- Set Fish as default shell
- Apply initial theme

**Then:** Logout → Select i3 → Login

---

## Usage

### Keybindings

`$mod` = `Super` (Mod4). Full reference — press `Super + Shift + h` on the desktop to see it live.

#### Launchers & apps

| Key                 | Action                              |
| :------------------ | :---------------------------------- |
| `Super + d`         | App launcher (rofi)                 |
| `Super + Enter`     | Terminal (alacritty)                |
| `Super + b`         | Browser (firefox)                   |
| `Super + Shift + f` | File manager (pcmanfm)              |
| `Super + Shift + e` | Power menu                          |
| `Super + Shift + b` | Wallpaper selector (rofi + m3wal)   |
| `Super + Shift + h` | Keybindings help                    |

#### Windows

| Key                          | Action                                    |
| :--------------------------- | :---------------------------------------- |
| `Super + Arrows`             | Focus window                              |
| `Super + Shift + Arrows`     | Move window (also `Shift + j/k/l/;`)      |
| `Super + a`                  | Focus parent container                    |
| `Super + Shift + q`          | Close window                              |
| `Super + f`                  | Fullscreen                                |
| `Super + h` / `Super + v`    | Split horizontal / vertical               |
| `Super + s` / `w` / `e`      | Layout: stacking / tabbed / toggle split  |
| `Super + Shift + v`          | Toggle floating (500x300, centered)       |
| `Super + r`                  | Resize mode (`Arrows` or `j/k/l/;`, exit with `Enter`/`Esc`) |

#### Workspaces

| Key                       | Action                        |
| :------------------------ | :---------------------------- |
| `Super + 1-0`             | Switch to workspace 1-10      |
| `Super + Shift + 1-0`     | Move window to workspace      |
| `Ctrl + Super + ←/→`      | Cycle workspaces (with loop)  |

#### Clipboard (clipmenu)

| Key                 | Action                                |
| :------------------ | :------------------------------------ |
| `Super + c`         | Clipboard history (rofi)              |
| `Super + Shift + x` | Clear clipboard (with confirmation)   |

#### Screenshots

| Key                 | Action                          |
| :------------------ | :------------------------------ |
| `Print`             | Full screen → `~/Pictures/Screenshots` |
| `Super + Shift + s` | Area selection → file           |
| `Super + Ctrl + s`  | Area selection → clipboard      |

#### Media & hardware

| Key                        | Action                              |
| :------------------------- | :---------------------------------- |
| `XF86Audio Raise/Lower`    | Volume ±1%                          |
| `XF86AudioMute`            | Toggle mute                         |
| `XF86Audio Play/Next/Prev` | Media control (playerctl)           |
| `XF86MonBrightness Up/Down`| Brightness                          |

#### System

| Key                 | Action                                  |
| :------------------ | :-------------------------------------- |
| `Super + l`         | Lock screen                             |
| `Super + Shift + r` | Restart i3 in place                     |
| `Super + Shift + c` | Reload i3 config                        |
| `Super + m`         | Voice control mode (exit: `Enter`/`Esc`)|

### Theming

**Change wallpaper:**

```bash
m3wal /path/to/wallpaper.jpg --full
```

**With options:**

```bash
m3wal wallpaper.jpg --full --mode dark --variant VIBRANT
m3wal wallpaper.jpg --full --mode light --variant EXPRESSIVE
m3wal wallpaper.jpg --full  # auto-detect (recommended)
```

**Variants:** `CONTENT` (default), `VIBRANT`, `EXPRESSIVE`, `NEUTRAL`, `TONALSPOT`, `FIDELITY`, `MONOCHROME`

**Modes:** `auto` (default), `light`, `dark`

---

## Configuration

### m3wal Config

`~/.config/m3-colors/m3-colors.conf`

```ini
[General]
mode = auto              # auto, light, dark
variant = CONTENT        # Color variant
operation_mode = full    # generator or full

[Features]
set_wallpaper = true
apply_xresources = true
generate_palette_preview = true
```

### Custom Templates

Create in `~/.config/m3-colors/templates/`:

```
# myapp.conf.template
background={{m3surface}}
foreground={{m3onSurface}}
primary={{m3primary}}
```

Deploy via `~/.config/m3-colors/deploy.json`:

```json
{
  "deployments": [
    { "source": "myapp.conf", "destination": "~/.config/myapp/colors.conf" }
  ]
}
```

### Hook Scripts

Create in `~/.config/m3-colors/hooks/`:

```bash
# Colors are available as environment variables
echo "Primary color: $M3_M3PRIMARY"
echo "Mode: $M3_MODE"
echo "Wallpaper: $M3_WALLPAPER"

# Reload applications
killall -USR1 kitty
i3-msg reload
notify-send "Theme Updated" "Applied $M3_MODE mode"
```

Enable:

```ini
[Hook.Scripts]
enabled = true
scripts = reload-apps.sh
```

---

## File Structure

```
~/.config/
├── i3/           # Window manager
├── alacritty/    # Terminal
├── rofi/         # Launcher
├── m3-colors/    # Theming
│   ├── templates/     # Color templates
│   ├── hooks/         # Scripts
│   └── deploy.json    # Deployment
└── fish/         # Shell

~/.local/bin/     # Scripts
~/Pictures/Wallpapers/  # Your wallpapers
```

---

## What's New

### Robust System Info

- **CPU Usage** — reads `/proc/stat` twice and calculates the diff, instead of parsing `top` output
- **CPU Temp** — priority order: hwmon with label → `thermal_zone` filtered by type (`x86_pkg_temp`/`acpitz`), not blindly using `zone0`
- **RAM** — uses `free -k` (pure kilobytes), human-readable format calculated manually without `sed 's/i//g'`

### Universal Hardware Detection

- **WiFi** — loops through `/sys/class/net/*/wireless/`, auto-detects `wlan0`, `wlp2s0`, `wlpXsY`, and any other name
- **Battery** — globs `BAT*`, `BATT*`, `battery*`, picks the first one with a `capacity` file
- **AC Adapter** — globs `ADP*`, `AC*`, `ACAD*`, works across different laptop models

---

## Troubleshooting

**Fonts missing:**

```bash
fc-cache -fv
```

**Transparency broken:**

```bash
picom --config ~/.config/picom/picom.conf &
```

**Manual wallpaper:**

```bash
feh --bg-scale /path/to/wallpaper.jpg
```

---

## Advanced

### Python API

```python
from m3wal import M3WAL

m3 = M3WAL("wallpaper.jpg")
m3.analyze_wallpaper()
m3.generate_scheme(mode="dark", variant="VIBRANT")
m3.apply_all_templates()
m3.deploy_configs()
```

### Random Wallpaper

```bash
m3wal $(find ~/Pictures/Wallpapers -type f | shuf -n1) --full
```

---

## Links

- [GitHub Issues](https://github.com/MDiaznf23/simple-autoricing-i3wm-dotfiles/issues)
- [m3wal](https://github.com/MDiaznf23/m3wal)
- [Arch Wiki - i3](https://wiki.archlinux.org/title/I3)

---

<div align="center">

**Made with ❤️ for Arch Linux**

⭐ Star if helpful!

</div>
