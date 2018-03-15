#!/bin/sh

make O=/tmp/result BR2_EXTERNAL=/br2-external raspberrypi2_stat_defconfig && make O=/tmp/result BR2_EXTERNAL=/br2-external
