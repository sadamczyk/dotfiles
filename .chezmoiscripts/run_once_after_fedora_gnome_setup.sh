#!/bin/bash

test -f /usr/bin/open || sudo ln -s /usr/bin/xdg-open /usr/bin/open

sudo dnf copr enable wezfurlong/wezterm-nightly
sudo dnf install -y wezterm

sudo dnf install -y \
  geary \
  google-chrome-stable

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y io.dbeaver.DBeaverCommunity

