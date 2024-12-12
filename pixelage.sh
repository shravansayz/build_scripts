#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pixelage .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/android_frameworks_base_pixelage.git -b 15 frameworks/base --depth=1

#Private Keys
rm -rf vendor/lineage-priv
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/lineage-priv

export PIXELAGE_BUILD=RMX1901
export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch pixelage_RMX1901-ap4a-user
mka installclean
mka bacon
