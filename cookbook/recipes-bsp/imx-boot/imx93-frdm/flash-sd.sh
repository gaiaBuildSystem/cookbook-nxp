#!/bin/bash

set -e

# get the /dev that is the sd card as first argument
SD_DEV=$1
FLASH_BIN=$2
IMAGE_FILE=$3

# Flash the full image (partition table + partitions starting at 8MB)
dd if=${IMAGE_FILE} of=${SD_DEV} bs=1M status=progress conv=fsync

# Flash the bootloader at 32KB (between partition table and first partition)
dd if=${FLASH_BIN} of=${SD_DEV} bs=1k seek=32 conv=notrunc,fsync

sync
echo "Flashing completed successfully."
exit 0
