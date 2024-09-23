#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b yaap-test .repo/local_manifests

if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Set up build environment
source build/envsetup.sh
lunch yaap_RMX1901-userdebug
m installclean
m yaap
