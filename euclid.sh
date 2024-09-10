#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/euclidTeam/manifest.git -b qpr3 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b euc .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch euclid_RMX1901-ap2a-user
make installclean
m euclid
