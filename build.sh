#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://gitlab.com/ThankYouHonami/manifest.git -b fourteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pixelos .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh


export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch aosp_RMX1901-ap2a-userdebug
make installclean
mka bacon

