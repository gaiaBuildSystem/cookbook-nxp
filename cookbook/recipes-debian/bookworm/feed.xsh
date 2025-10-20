#!/usr/bin/env xonsh

# Copyright (c) 2025 MicroHobby
# SPDX-License-Identifier: MIT

# use the xonsh environment to update the OS environment
$UPDATE_OS_ENVIRON = True
# always return if a cmd fails
$RAISE_SUBPROC_ERROR = True
$XONSH_SHOW_TRACEBACK = True

import os
import json
import os.path
from torizon_templates_utils.colors import print,BgColor,Color
from torizon_templates_utils.errors import Error_Out,Error


print(
    "Deploying imx8 debian feed ...",
    color=Color.WHITE,
    bg_color=BgColor.GREEN
)

# get the common variables
_ARCH = os.environ.get('ARCH')
_MACHINE = os.environ.get('MACHINE')
_MAX_IMG_SIZE = os.environ.get('MAX_IMG_SIZE')
_BUILD_PATH = os.environ.get('BUILD_PATH')
_DISTRO_MAJOR = os.environ.get('DISTRO_MAJOR')
_DISTRO_MINOR = os.environ.get('DISTRO_MINOR')
_DISTRO_PATCH = os.environ.get('DISTRO_PATCH')
_USER_PASSWD = os.environ.get('USER_PASSWD')

# read the meta data
meta = json.loads(os.environ.get('META', '{}'))

# get the actual script path, not the process.cwd
_path = os.path.dirname(os.path.abspath(__file__))

_IMAGE_MNT_BOOT = f"{_BUILD_PATH}/tmp/{_MACHINE}/mnt/boot"
_IMAGE_MNT_ROOT = f"{_BUILD_PATH}/tmp/{_MACHINE}/mnt/root"
_BUILD_ROOT = f"{_BUILD_PATH}/tmp/{_MACHINE}"
os.environ['IMAGE_MNT_BOOT'] = _IMAGE_MNT_BOOT
os.environ['IMAGE_MNT_ROOT'] = _IMAGE_MNT_ROOT
$BUILD_ROOT = _BUILD_ROOT


# first install curl and gnupg
sudo chroot @(_IMAGE_MNT_ROOT) \
    bash -c 'apt-get update && apt-get install -y curl gnupg'

# TODO: we have a bug on the Toradex feed that needs to be fixed first
if _MACHINE == "imx8mp-verdin-none":
    # get the key
    sudo chroot @(_IMAGE_MNT_ROOT) \
        bash -c 'curl -fsSL https://feeds.toradex.com/stable/imx8/toradex-debian-repo-07102024.asc | gpg --dearmor > /usr/share/keyrings/toradex-debian-repo.gpg'

    # add the toradex feed
    sudo cp @(_path)/files/toradex.sources \
        @(_IMAGE_MNT_ROOT)/etc/apt/sources.list.d/toradex.sources

    # add the origin pin
    sudo cp @(_path)/files/toradex-feeds \
        @(_IMAGE_MNT_ROOT)/etc/apt/preferences.d/toradex-feeds

    # TODO: this is not needed? maybe only for containers
    # # add the buildconfig
    # sudo cp @(_path)/files/01_buildconfig \
    #     @(_IMAGE_MNT_ROOT)/etc/apt/apt.conf.d/01_buildconfig

else:
    print(
        f"Skipping feed installation for machine '{_MACHINE}'",
        color=Color.YELLOW
    )


print(
    "Deploying imx8 debian feed, ok",
    color=Color.WHITE,
    bg_color=BgColor.GREEN
)
