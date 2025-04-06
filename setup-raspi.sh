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
  unclutter

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


