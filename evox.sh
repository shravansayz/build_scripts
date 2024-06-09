#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/Evolution-XYZ/manifest -b udc --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b evox .repo/local_manifests

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_evox.git -b udc frameworks/base --depth=1

# Set up build environment
source build/envsetup.sh
lineage_RMX1901-userdebug
make install clean
m evolution
