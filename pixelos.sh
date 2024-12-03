#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init --depth=1 -u https://github.com/PixelOS-Fifteen/manifest.git -b fifteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b pixel .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone -b fifteen https://github.com/shravansayz/frameworks_base_pixelos.git frameworks/base --depth=1

#Private Keys
rm -rf vendor/aosp/signing
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/aosp/signing

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Set up build environment
source build/envsetup.sh
lunch aosp_RMX1901-ap3a-user
make installclean
mka bacon
