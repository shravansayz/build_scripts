#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pos14 .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_pos.git -b fourteen frameworks/base --depth=1

rm -rf vendor/aosp
git clone https://github.com/shravansayz/vendor_aosp.git -b fourteen vendor/aosp --depth=1

rm -rf vendor/extra
git clone https://github.com/shravansayz/vendor_extra.git -b master vendor/extra --depth=1

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch aosp_RMX1901-ap2a-user
make installclean
mka bacon
