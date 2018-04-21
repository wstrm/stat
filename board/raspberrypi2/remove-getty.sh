#!/bin/sh

# disable getty (gets enabled even if disabled in buildroot)
sed -i "\|tty1::respawn:/sbin/getty|s|^|#|" ${TARGET_DIR}/etc/inittab
