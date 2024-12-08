#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/GenesisOS/manifest.git -b verve --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b genesis .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#Private Keys
rm -rf vendor/genesis/signing
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/genesis/signing

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Set up build environment
source build/envsetup.sh
breakfast RMX1901
make installclean
mka genesis
