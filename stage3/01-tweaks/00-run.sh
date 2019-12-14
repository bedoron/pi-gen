#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"

on_chroot << EOF
mkdir -p ~/.ssh/
ssh-keyscan github.com >> ~/.ssh/known_hosts
cd /tmp
git clone git@github.com:jasbur/RaspiWiFi.git
cd /tmp/RaspiWifi
python3 initial_setup.py
EOF
