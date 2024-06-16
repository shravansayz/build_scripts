#!/bin/bash

# Removals
rm -rf .repo/local_manifests
rm -rf vendor/evolution-priv
rm -rf frameworks/base

# Initialize repo with specified manifest
repo init -u https://github.com/Evolution-XYZ/manifest -b udc --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b evox .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
git clone https://github.com/shravansayz/frameworks_base_evox.git -b udc frameworks/base --depth=1

# Private Keys
git clone https://github.com/shravansayz/private_keys_evox.git -b main vendor/evolution-priv

# Set up build environment
source build/envsetup.sh

# Lunch configuration
lunch lineage_RMX1901-user

# Cleanup directories
# make installclean

# Git-lfs
repo forall -c 'git lfs install && git lfs pull && git lfs checkout'

# Build
m evolution
