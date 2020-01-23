#!/bin/bash -e

on_chroot << EOF
pip3 install APSCheduler requests urllib3
EOF
