#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --depth=1 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b derp14 .repo/local_manifests

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_derp.git -b 14 frameworks/base --depth=1

# Private Keys
wget https://github.com/shravansayz/local_manifests/raw/keys/keys.zip && unzip -o keys.zip -d vendor/derp/signing/keys && rm keys.zip

# Set up build environment
source build/envsetup.sh
lunch derp_RMX1901-user
make install clean
mka derp
