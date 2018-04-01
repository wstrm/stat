#!/bin/sh

# remove console=tty1
echo "root=/dev/mmcblk0p2 rootwait console=ttyAMA0,115200" > ${BINARIES_DIR}/rpi-firmware/cmdline.txt 
