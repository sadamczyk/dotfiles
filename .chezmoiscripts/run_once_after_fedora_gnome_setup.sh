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

# Install Docker-CE
# https://docs.docker.com/engine/install/fedora/
sudo dnf -y install dnf-plugins-core \
  && sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
  && sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  # TODO Add $USER to docker group?
  && sudo systemctl enable docker.service \
  && sudo systemctl enable containerd.service \
  # Fix extremely slow RPM package installation (yum etc.)
  # Fixed in the docker images of newer RPM-based distros: https://github.com/rpm-software-management/rpm/commit/5e6f05cd8dad6c1ee6bd1e6e43f176976c9c3416
  && sudo sed -i 's/LimitNOFILE=infinity/LimitNOFILE=1024/' /usr/lib/systemd/system/docker.service

