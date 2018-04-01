Stat
====

Stat is a operating system that starts a simple web browser (in the framebuffer) as quickly as possible.

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
