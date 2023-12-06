#!/bin/sh
# Non-root user installs

# Install gita via brew once resolved: https://github.com/nosarthur/gita/issues/80
pip3 install --upgrade gita

# Install LSPs
# https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers
npm install -g typescript typescript-language-server
pip3 install --upgrade 'python-lsp-server[all]'

# GNOME settings & extensions
test -d ~/Projects || mkdir -p ~/Projects
test -d ~/Apps || mkdir -p ~/Apps
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:backspace']" # Set Capslock as Escape
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts [] \
  && gsettings set org.gnome.desktop.wm.keybindings close "['<Super>Escape']" # Close window (removes conflicting shortcut)
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']" # Open file explorer
gsettings set org.gnome.desktop.wm.keybindings switch-group [] \
  && gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Alt>grave']" # Switch between windows of an app directly
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat # Disable mouse acceleration
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false # Disable natural scrolling for mice
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true # Tap touchpad to click
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false # Disable natural scrolling for touchpad
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true # Enable Night Light
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 7200 # Automatic Suspend on AC power after 2h
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800 # Automatic Suspend on battery power after 30m
gsettings set org.gnome.desktop.session idle-delay 900 # Turn screen blank after 15m
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false # Disable screen dimming because it happens way too quickly (30s), which seemingly can't be changed
gsettings set org.gnome.desktop.screensaver lock-delay 30 # Lock screen 30s after going blank
gsettings set org.gnome.desktop.privacy recent-files-max-age 30 # Only remember recently used files for 30 days
gsettings set org.gnome.desktop.privacy remove-old-trash-files true # Automatically delete trash
gsettings set org.gnome.desktop.privacy remove-old-temp-files true # Automatically delete temp files
pip3 install --upgrade gnome-extensions-cli

# Interactive / manual commands at the end
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
command -v slack >/dev/null || {
  google-chrome https://slack.com/intl/de-de/downloads/linux 2>/dev/null &
  google-chrome https://www.jetbrains.com/de-de/phpstorm/download/#section=linux 2>/dev/null &
  sleep 5 # Give browser a moment to open
}

