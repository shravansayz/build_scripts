#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs --depth=1
git clone https://github.com/shravansayz/local_manifests.git -b pos .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_pos.git -b fourteen frameworks/base --depth=1

#ksu
cd kernel/realme/sdm710 && curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash - && cd ../../..

# build
. build/envsetup.sh
lunch aosp_RMX1901-ap1a-userdebug
m installclean
mka bacon

# crave build command
#crave run --no-patch "rm -rf build.sh && wget https://raw.githubusercontent.com/shravansayz/build_scripts/pos/build.sh && bash build.sh"
