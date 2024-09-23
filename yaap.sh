#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b yaap-test .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh && /opt/crave/resync.sh

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

# Git-lfs
repo forall -c 'git lfs install && git lfs pull'

# Set up build environment
source build/envsetup.sh
lunch yaap_RMX1901-userdebug
make installclean
m yaap
