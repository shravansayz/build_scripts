#!/bin/bash

#removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b rise .repo/local_manifests

# Sync the repositories
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/android_frameworks_base_rise.git -b fourteen frameworks/base --depth=1

# Private Keys
rm -rf vendor/lineage-priv && git clone https://github.com/shravansayz/vendor_lineage-priv vendor/lineage-priv

# Set up build environment
source build/envsetup.sh
genkeys shravankumarsayz@gmail.com

# Lunch configuration
riseup RMX1901 user
make installclean

# Build
croot
repo forall -c 'git lfs install && git lfs pull && git lfs checkout'
rise sb
