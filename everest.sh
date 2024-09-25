#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b everest .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_everest.git -b 14 frameworks/base --depth=1

#Private Keys
rm -rf vendor/lineage/keys
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/lineage/keys

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Set up build environment
source build/envsetup.sh
lunch lineage_RMX1901-user
make install clean
mka everest
