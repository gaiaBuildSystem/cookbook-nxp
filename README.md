# Cookbook for NXP iMX Platform Machines

<p align="center">
    <img
        src="https://www.nxp.com/assets/images/en/logos-internal/NXP_logo_RGB_web.jpg"
        alt="Rpi Logo"
        width="300" />
</p>

This cookbook provides a collection of recipes to help you get started with DeimOS for NXP iMX Platform based boards.

## Supported Boards -> Machine

> ⚠️ As this grows we could change the machine name to a more generic name.

| Board                       | Gaia Machine Name   |
|-----------------------------|---------------------|
| Toradex iMX95 EVK           | imx95-verdin-evk    |
| Toradex Verdin iMX8M Plus   | imx8mp-verdin       |

## Prerequisites

- [Gaia project Gaia Core](https://github.com/gaiaBuildSystem/gaia);

<p align="center">
    <img
        src="https://github.com/gaiaBuildSystem/.github/raw/main/profile/GaiaBuildSystemLogoDebCircle.png"
        alt="This is a Gaia Project based cookbook"
        width="170" />
</p>

## Build an Image

```bash
./gaia/scripts/bitcook/gaia.ts --buildPath /home/user/workdir --distro ./cookbook-nxp/distro-ref-imx95-verdin-evk.json
```

This will build DeimOS for Toradex iMX95 Verdin EVK.
