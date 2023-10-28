#!/bin/bash

dnf upgrade --refresh -y

test -f /usr/bin/open || ln -s /usr/bin/xdg-open /usr/bin/open

dnf copr enable -y wezfurlong/wezterm-nightly
dnf config-manager --set-enabled google-chrome
dnf install -y \
  geary \
  google-chrome-stable \
  wezterm

# Install DBeaver
curl -LO https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
dnf localinstall -y dbeaver-ce-latest-stable.x86_64.rpm
rm dbeaver-ce-latest-stable.x86_64.rpm

# Install Docker-CE
# https://docs.docker.com/engine/install/fedora/
# The sed command fixes extremely slow RPM package installation (yum etc.);
# fixed in the docker images of newer RPM-based distros: https://github.com/rpm-software-management/rpm/commit/5e6f05cd8dad6c1ee6bd1e6e43f176976c9c3416
dnf -y install dnf-plugins-core \
  && dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
  && dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  && usermod -aG docker $USER \
  && systemctl enable docker.service \
  && systemctl enable containerd.service \
  && sed -i 's/LimitNOFILE=infinity/LimitNOFILE=1024/' /usr/lib/systemd/system/docker.service

# Install Google Cloud CLI
# https://cloud.google.com/sdk/docs/install-sdk?hl=de#rpm
tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
dnf install -y libxcrypt-compat.x86_64 \
  && dnf install -y google-cloud-cli google-cloud-cli-skaffold google-cloud-cli-gke-gcloud-auth-plugin
test -d /home/$SUDO_USER/.config/gcloud/ || sudo -u $SUDO_USER gcloud init

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Programs that need to be installed manually
sudo -u $SUDO_USER google-chrome https://slack.com/intl/de-de/downloads/linux 2>/dev/null &
sudo -u $SUDO_USER google-chrome https://www.jetbrains.com/de-de/phpstorm/download/#section=linux 2>/dev/null &

