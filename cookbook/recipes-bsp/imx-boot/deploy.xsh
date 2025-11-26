#!/usr/bin/env xonsh

# Copyright (c) 2025 MicroHobby
# SPDX-License-Identifier: MIT

# use the xonsh environment to update the OS environment
$UPDATE_OS_ENVIRON = True
# always return if a cmd fails
$RAISE_SUBPROC_ERROR = True


import os
import json
import os.path
from torizon_templates_utils.colors import print,BgColor,Color
from torizon_templates_utils.errors import Error_Out,Error


print("Deploying imx-boot artifacts ...", color=Color.WHITE, bg_color=BgColor.GREEN)

# get the common variables
_ARCH = os.environ.get('ARCH')
_MACHINE = os.environ.get('MACHINE')
_MAX_IMG_SIZE = os.environ.get('MAX_IMG_SIZE')
_BUILD_PATH = os.environ.get('BUILD_PATH')
_DISTRO_MAJOR = os.environ.get('DISTRO_MAJOR')
_DISTRO_MINOR = os.environ.get('DISTRO_MINOR')
_DISTRO_PATCH = os.environ.get('DISTRO_PATCH')
_USER_PASSWD = os.environ.get('USER_PASSWD')

# check if we have the DISTRO_VARIANT env
if 'DISTRO_VARIANT' in os.environ:
    _DISTRO_VARIANT = f"{os.environ.get('DISTRO_VARIANT')}-"
else:
    _DISTRO_VARIANT = ""

# read the meta data
meta = json.loads(os.environ.get('META', '{}'))

# get the actual script path, not the process.cwd
_path = os.path.dirname(os.path.abspath(__file__))

_IMAGE_MNT_BOOT = f"{_BUILD_PATH}/tmp/{_MACHINE}/mnt/boot"
_IMAGE_MNT_ROOT = f"{_BUILD_PATH}/tmp/{_MACHINE}/mnt/root"
os.environ['IMAGE_MNT_BOOT'] = _IMAGE_MNT_BOOT
os.environ['IMAGE_MNT_ROOT'] = _IMAGE_MNT_ROOT

if os.environ["MACHINE"] == "imx95-verdin-evk":

    # replace all the {{VAR}} with the actual values
    f = open(f"{_path}/imx95-verdin-evk/uuu.mmc.template", "r")
    uuu_mmc = f.read()
    uuu_mmc = uuu_mmc.replace("{{variant}}", _DISTRO_VARIANT)
    uuu_mmc = uuu_mmc.replace("{{v1}}", _DISTRO_MAJOR)
    uuu_mmc = uuu_mmc.replace("{{v2}}", _DISTRO_MINOR)
    uuu_mmc = uuu_mmc.replace("{{v3}}", _DISTRO_PATCH)
    f.close()

    # write the new uuu.mmc
    f = open(f"{_BUILD_PATH}/tmp/{_MACHINE}/imx-mkimage/iMX95/uuu.mmc", "w")
    f.write(uuu_mmc)
    f.close()

    # copy the uuu.mmc to the deploy folder
    sudo -k \
        cp @(_BUILD_PATH)/tmp/@(_MACHINE)/imx-mkimage/iMX95/uuu.mmc @(_BUILD_PATH)/tmp/@(_MACHINE)/deploy/uuu.mmc

elif os.environ["MACHINE"] == "smarc-imx95":

    # replace all the {{VAR}} with the actual values
    f = open(f"{_path}/smarc-imx95/uuu.mmc.template", "r")
    uuu_mmc = f.read()
    uuu_mmc = uuu_mmc.replace("{{variant}}", _DISTRO_VARIANT)
    uuu_mmc = uuu_mmc.replace("{{v1}}", _DISTRO_MAJOR)
    uuu_mmc = uuu_mmc.replace("{{v2}}", _DISTRO_MINOR)
    uuu_mmc = uuu_mmc.replace("{{v3}}", _DISTRO_PATCH)
    f.close()

    # write the new uuu.mmc
    f = open(f"{_BUILD_PATH}/tmp/{_MACHINE}/imx-mkimage/iMX95/uuu.mmc", "w")
    f.write(uuu_mmc)
    f.close()

    # copy the uuu.mmc to the deploy folder
    sudo -k \
        cp @(_BUILD_PATH)/tmp/@(_MACHINE)/imx-mkimage/iMX95/uuu.mmc @(_BUILD_PATH)/tmp/@(_MACHINE)/deploy/uuu.mmc

elif os.environ["MACHINE"] == "imx8mp-verdin":

    # replace all the {{VAR}} with the actual values
    f = open(f"{_path}/imx8mp-verdin/uuu.mmc.template", "r")
    uuu_mmc = f.read()
    uuu_mmc = uuu_mmc.replace("{{variant}}", _DISTRO_VARIANT)
    uuu_mmc = uuu_mmc.replace("{{v1}}", _DISTRO_MAJOR)
    uuu_mmc = uuu_mmc.replace("{{v2}}", _DISTRO_MINOR)
    uuu_mmc = uuu_mmc.replace("{{v3}}", _DISTRO_PATCH)
    f.close()

    # write the new uuu.mmc
    f = open(f"{_BUILD_PATH}/tmp/{_MACHINE}/imx-mkimage/iMX8M/uuu.mmc", "w")
    f.write(uuu_mmc)
    f.close()

    # copy the uuu.mmc to the deploy folder
    sudo -k \
        cp @(_BUILD_PATH)/tmp/@(_MACHINE)/imx-mkimage/iMX8M/uuu.mmc @(_BUILD_PATH)/tmp/@(_MACHINE)/deploy/uuu.mmc

elif os.environ["MACHINE"] == "imx93-frdm":

    # replace all the {{VAR}} with the actual values
    f = open(f"{_path}/imx93-frdm/uuu.mmc.template", "r")
    uuu_mmc = f.read()
    uuu_mmc = uuu_mmc.replace("{{variant}}", _DISTRO_VARIANT)
    uuu_mmc = uuu_mmc.replace("{{v1}}", _DISTRO_MAJOR)
    uuu_mmc = uuu_mmc.replace("{{v2}}", _DISTRO_MINOR)
    uuu_mmc = uuu_mmc.replace("{{v3}}", _DISTRO_PATCH)
    f.close()

    # write the new uuu.mmc
    f = open(f"{_BUILD_PATH}/tmp/{_MACHINE}/imx-mkimage/iMX93/uuu.mmc", "w")
    f.write(uuu_mmc)
    f.close()

    # copy the uuu.mmc to the deploy folder
    sudo -k \
        cp @(_BUILD_PATH)/tmp/@(_MACHINE)/imx-mkimage/iMX93/uuu.mmc @(_BUILD_PATH)/tmp/@(_MACHINE)/deploy/uuu.mmc

else:
    Error_Out(
        f"Machine [{os.environ['MACHINE']}] is not supported",
        Error.EINVAL
    )

print("Deploying imx-boot artifacts, OK", color=Color.WHITE, bg_color=BgColor.GREEN)
