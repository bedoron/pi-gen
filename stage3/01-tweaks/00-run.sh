#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"

on_chroot << EOF
mkdir -p ~/.ssh/
ssh-keyscan github.com >> ~/.ssh/known_hosts
cd ~/ && [ ! -d "RaspiWiFi" ] && git clone https://github.com/jasbur/RaspiWiFi.git
cd ~/RaspiWiFi && \
    python3 -c 'import setup_lib; setup_lib.install_prereqs()' && \
    python3 -c 'import setup_lib; setup_lib.copy_configs("N")' && \
    python3 -c 'import setup_lib; setup_lib.update_main_config_file("", "y", "30", "N", "80", "N", "N")'
EOF
