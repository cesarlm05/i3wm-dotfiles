#!/bin/bash
source ~/.config/i3/config-dotfiles
eww update \
  dotfiles-window-open=true \
  dotfiles-icon-theme="$ICON_THEME" \
  dotfiles-max-workspaces="$MAX_WORKSPACES"
