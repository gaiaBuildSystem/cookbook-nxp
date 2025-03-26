#!/bin/bash

set -e

if [ "$SOC_TARGET" == "iMX95" ]; then
    cd $BUILD_PATH/tmp/$MACHINE/imx-mkimage

    make \
        SOC=$SOC_TARGET \
        OEI=YES \
        LPDDR_TYPE=lpddr5 \
        QSPI_HEADER=./scripts/fspi_header_133 \
        dtbs=${UBOOT_DTB_NAME} \
        flash_all

    sudo -k \
        cp -f $BUILD_PATH/tmp/$MACHINE/imx-mkimage/iMX95/flash.bin $BUILD_PATH/tmp/$MACHINE/deploy/
else
    # exception
    echo "SOC_TARGET is not supported"
    exit 69
fi
