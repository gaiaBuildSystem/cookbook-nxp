#!/bin/bash

set -e

# match the machine for the soc_target
if [ "$MACHINE" == "imx95-verdin-evk" ]; then
    SOC_TARGET="iMX95"
elif [ "$MACHINE" == "smarc-imx95" ]; then
    SOC_TARGET="iMX95"
elif [ "$MACHINE" == "imx8mp-verdin" ]; then
    SOC_TARGET="iMX8MP"
elif [ "$MACHINE" == "imx93-frdm" ]; then
    SOC_TARGET="iMX93"
else
    # exception
    echo "MACHINE is not supported"
    exit 69
fi


if [ "$SOC_TARGET" == "iMX95" ]; then
    cd $BUILD_PATH/tmp/$MACHINE/imx-mkimage

    if [ "$MACHINE" == "imx95-verdin-evk" ]; then
        make \
            SOC=$SOC_TARGET \
            OEI=YES \
            LPDDR_TYPE=lpddr5 \
            QSPI_HEADER=./scripts/fspi_header_133 \
            dtbs=${UBOOT_DTB_NAME} \
            flash_all

    elif [ "$MACHINE" == "smarc-imx95" ]; then
        make \
            SOC=$SOC_TARGET \
            OEI=YES \
            LPDDR_TYPE=lpddr5 \
            LPDDR_FW_VERSION="_v202409" \
            REV=B0 \
            dtbs=${UBOOT_DTB_NAME} \
            flash_a55

    fi

    sudo -k \
        cp -f $BUILD_PATH/tmp/$MACHINE/imx-mkimage/iMX95/flash.bin $BUILD_PATH/tmp/$MACHINE/deploy/

elif [ "$SOC_TARGET" == "iMX8MP" ]; then
    cd $BUILD_PATH/tmp/$MACHINE/imx-mkimage

    make \
        SOC=$SOC_TARGET \
        mkimage_imx8

    # the u-boot seems to generate the flash.bin for us
    sudo -k \
        cp -f $BUILD_PATH/tmp/$MACHINE/u-boot/flash.bin $BUILD_PATH/tmp/$MACHINE/deploy/

elif [ "$SOC_TARGET" == "iMX93" ]; then
    cd $BUILD_PATH/tmp/$MACHINE/imx-mkimage

    make \
        SOC=$SOC_TARGET \
        flash_singleboot

    sudo -k \
        cp -f $BUILD_PATH/tmp/$MACHINE/imx-mkimage/iMX93/flash.bin $BUILD_PATH/tmp/$MACHINE/deploy/

fi
