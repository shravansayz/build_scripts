#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pos14 .repo/local_manifests

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_pos.git -b fourteen frameworks/base --depth=1

#build
. build/envsetup.sh
lunch aosp_RMX1901-ap1a-userdebug
mka target-files-package otatools

#sign build
rm -rf sign.sh && wget https://raw.githubusercontent.com/shravansayz/build_scripts/pos/sign.sh && bash sign.sh
