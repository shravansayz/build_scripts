#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/halcyonproject/manifest -b 14.3 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b halcyon  .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#Private Keys
rm -rf vendor/halcyon-priv
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/halcyon-priv

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Git-lfs
repo forall -c 'git lfs install && git lfs pull'

# Set up build environment
source build/envsetup.sh
lunch halcyon_RMX1901-ap2a-user
m installclean
make carthage
