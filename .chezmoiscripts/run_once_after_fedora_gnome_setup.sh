#!/bin/bash

test -f /usr/bin/open || sudo ln -s /usr/bin/xdg-open /usr/bin/open

sudo dnf copr enable -y wezfurlong/wezterm-nightly
sudo dnf install -y \
  geary \
  google-chrome-stable \
  wezterm

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install DBeaver
curl -LO https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo dnf localinstall -y dbeaver-ce-latest-stable.x86_64.rpm
rm dbeaver-ce-latest-stable.x86_64.rpm