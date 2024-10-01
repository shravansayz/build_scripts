#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/GenesisOS/manifest.git -b utopia-3.0 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b blaze  .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh && /opt/crave/resync.sh

#Private Keys
rm -rf vendor/genesis/signing
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/genesis/signing

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Git-lfs
repo forall -c 'git lfs install && git lfs pull'

# Set up build environment
source build/envsetup.sh
lunch genesis_RMX1901-user
make installclean
mka genesis
