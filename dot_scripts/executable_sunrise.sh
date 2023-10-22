#!/usr/bin/env sh
# Shell commands to run when GNOME Night Theme Switcher switches to day
# Enable light modes etc.

set -e

# Update kitty theme
kitty +kitten themes --reload-in=all Solarized Light

# Update Helix Editor config to use light theme.
sed -i 's/theme = ".*"/theme = "solarized_light"/' ${HOME}/.config/helix/config.toml
pkill -USR1 hx || true

# Update git-delta to use light theme
sed -i 's/light = .*/light = true/' ${HOME}/.config/git/config