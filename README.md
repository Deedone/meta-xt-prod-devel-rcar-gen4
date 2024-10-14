# meta-xt-prod-v4h-demo

This repository contains yocto meta layers and product configuration
customized for the V4H Whitehawk Demo.
The demo is based on the xen-troops/meta-xt-prod-devel-rcar-gen4 repo.

This demo provides the following features:

 - Xen build compatible with V4H SoC
 - Thin Dom0 (no hardware present)
 - ADAS domain (DomD)
 - IVI Domain (DomU)
 - GPU passthrough in DomU
 - PCI passthrough in DomU
 - Camera in DomU

# How to build the demo

## Prerequirements

The buld was tested on the Ubuntu 20.04 LTS.
Recommended hardware on the build host: intel i7, RAM 32GB, SSD with 150GB of free space.

The demo is configured to be used with the [moulin build system](https://moulin.readthedocs.io/en/latest/).

Install moulin
```
pip3 install --user git+https://github.com/xen-troops/moulin
```

Install ninja
```
apt install ninja-build
```

Other packages may be required to be installed depending on the build host.

[TODO] describe full list of packages

## Building

You have to fetch whole this product or download it as package.

```
git clone https://partnergitlab.renesas.solutions/v4h-fusion-poc/meta-xt-prod-v4h-demo.git
cd meta-xt-prod-v4h-demo
```

Put DDK packages inside
```
cp <some_path>/GSX_KM_V4H_DDK23.3_v2.tar.bz2 .
cp <some_path>/r8a779g0_linux_gsx_binaries_gles_vz_DDK23.3_v2.tar.bz2 .
```

Run moulin to create build.ninja file
```
moulin prod-devel-rcar4.yaml --MACHINE whitehawk --ENABLE_DOMU yes
```

Start the build
```
ninja full.img
```

## Flashing

Flash the IPLs
[TODO]

Flash the bl31 and u-boot from the product
[TODO]

Flash the image and add test tools
[TODO]

## Run on the board
```
env delete bootargs; ext4load mmc 0:1 0x83000000 boot-emmc.uImage; source 0x83000000
```

## Testing
[TODO]


