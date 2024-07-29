#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/Project-PixelStar/manifest -b 14-qpr3

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pixelp14 .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_pixelstar.git -b 14-qpr3 frameworks/base --depth=1

# Private Keys
rm -rf vendor/pixelstar/signing
git clone https://github.com/shravansayz/private_keys.git -b pixelpro vendor/pixelstar/signing

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch pixelstar_RMX1901-user
make installclean
mka bacon
