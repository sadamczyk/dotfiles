#!/bin/sh
# Non-root user installs

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

bash -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

# GNOME settings & extensions
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:backspace']" # Set Capslock as Escape
pip3 install --upgrade gnome-extensions-cli

# Interactive / manual commands at the end
# clear
# The prompt for the installation of the GNOME extensions times out quite quickly,
# so run gcloud init first instead, since it also requires confirmation, but doesn't timeout.
# Gives some time to come back to the machine after all the long previous installation steps
test -d ~/.config/gcloud/ || gcloud init

gext update --install -y \
  another-window-session-manager@gmail.com \
  appindicatorsupport@rgcjonas.gmail.com \
  hotedge@jonathan.jdoda.ca \
  nightthemeswitcher@romainvigier.fr \
  focused-window-dbus@flexagoon.com \
  && {
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/nightthemeswitcher@romainvigier.fr/schemas/ set org.gnome.shell.extensions.nightthemeswitcher.commands sunrise "~/.scripts/sunrise.sh";
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/nightthemeswitcher@romainvigier.fr/schemas/ set org.gnome.shell.extensions.nightthemeswitcher.commands sunset "~/.scripts/sunset.sh";
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/nightthemeswitcher@romainvigier.fr/schemas/ set org.gnome.shell.extensions.nightthemeswitcher.commands enabled true;
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/nightthemeswitcher@romainvigier.fr/schemas/ set org.gnome.shell.extensions.nightthemeswitcher.gtk-variants enabled true;
  }

# Programs that need to be installed manually
google-chrome https://slack.com/intl/de-de/downloads/linux 2>/dev/null &
google-chrome https://www.jetbrains.com/de-de/phpstorm/download/#section=linux 2>/dev/null &
sleep 5 # Give browser a moment to open

