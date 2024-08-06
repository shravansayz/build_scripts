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

# Private Keys
rm -rf vendor/aosp/signing
git clone https://github.com/shravansayz/private_keys.git -b pixelpro vendor/aosp/signing --depth=1

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch aosp_RMX1901-ap2a-userdebug
make installclean
mka bacon
