#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/ProjectEverest/manifest -b qpr3 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b everest .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_eve.git -b qpr3 frameworks/base --depth=1

# Private Keys
rm -rf vendor/everest/signing
git clone https://github.com/shravansayz/test_keys.git -b blaze vendor/everest/signing

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch everest_RMX1901-user
make installclean
make bacon
