#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"

cat >> "${ROOTFS_DIR}/etc/modules" << EOL

i2c-dev
i2c-bcm2708
EOL


PROJECT_DIR=${ROOTFS_DIR}/home/${FIRST_USER_NAME}/pimoroni-scrollbot-workshop

if [ ! -d ${PROJECT_DIR} ]; then
    git clone git@github.com:yoada/pimoroni-scrollbot-workshop.git ${PROJECT_DIR}
fi

chmod +x ${PROJECT_DIR}/scrollbot.sh
chmod +x ${PROJECT_DIR}/tools/welcomer.py
chmod +x ${PROJECT_DIR}/solution.py
chmod +x ${PROJECT_DIR}/app.py

on_chroot << EOF
systemctl enable /home/${FIRST_USER_NAME}/pimoroni-scrollbot-workshop/scrollbot.service
systemctl start scrollbot.service
EOF
