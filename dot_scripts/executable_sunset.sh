#!/usr/bin/env sh
# Shell commands to run when GNOME Night Theme Switcher switches to night
# Enable dark modes etc.

set -e

sed -i 's/theme = ".*"/theme = "solarized_dark"/' ${HOME}/.config/helix/config.toml
pkill -USR1 hx || true
