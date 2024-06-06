#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b rise .repo/local_manifests

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/android_frameworks_base_rise.git -b fourteen frameworks/base --depth=1

# Private Keys
git clone https://github.com/shravansayz/vendor_lineage-priv vendor/lineage-priv

# Set up build environment
source build/envsetup.sh
genkeys shravankumarsayz@gmail.com
# Lunch configuration
riseup RMX1901 user

# Cleanup directories
make installclean

# Build
rise sb
