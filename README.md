Stat
====

Stat is a operating system that starts a simple web browser (without X11, using EGLFS) as quickly as possible in order to show web-based statistics. The browser opens in fullscreen and borderless mode which is developed in Qt. 
Developed towards the Raspberry Pi 2, this can easily changed by adding a new defconfig for your specific board.

## Build
### With Docker
Create a output directory:
```
mkdir /tmp/result
```

Build the Docker container:
```
docker build . -t stat:latest
```

Start the compilation:
```
docker run -it -v /tmp/result:/home/bob/output stat:latest
```

The resulting image in `/tmp/result/images/sdcard.img` can be flashed to a SD-card with `dd` (make sure you replace `/dev/mmcblk0` with the correct device):
```
dd if=/tmp/result/images/sdcard.img of=/dev/mmcblk0 ; sync
```

### Without Docker
Make sure you have all dependencies that Buildroot requires and run:
```
./bin/build raspberrypi2_stat_defconfig
```

The resulting image in `output/images/sdcard.img` can be flashed to a SD-card with `dd` (make sure you replace `/dev/mmcblk0` with the correct device):
```
dd if=output/images/sdcard.img of=/dev/mmcblk0 ; sync
```
