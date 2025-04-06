#!/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
  echo "Please run this script as root or using sudo!"
  exit 1
fi

# Setup autologin, TODO: maybe make username dynamic?
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d

cat > /etc/systemd/system/getty@tty1.service.d/override.conf << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin sumika --noclear %I $TERM
EOF

systemctl daemon-reexec

# Install x11
apt-get update && apt install --no-install-recommends \
  xserver-xorg \
  x11-xserver-utils \
  xinit \
  unclutter \
  libgtk-3-0 \
  libnss3 \
  libxss1 \
  libasound2 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libxcomposite1 \
  libxrandr2 \
  libxdamage1 \
  libxkbcommon0 \
  libgbm1

# Setup x11
ln -s "$(realpath ./rpi/xinitrc)" $HOME/.xinitrc

# Setup systemd

cat > /etc/systemd/system/electron-kiosk.service << EOF
[Unit]
Description=Sumika
After=network.target

[Service]
User=pi
Environment=HOME=$HOME
ExecStart=$(realpath ./rpi/launchx.sh)
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl enable electron-kiosk
# systemctl start electron-kiosk

reboot


