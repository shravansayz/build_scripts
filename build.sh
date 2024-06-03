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

#Kernelsu
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s v0.9.5 && cd ../../..

rm -rf vendor/extra
git clone https://github.com/shravansayz/vendor_extra -b master vendor/extra

#rm -rf vendor/aosp/signing
#git clone https://github.com/shravansayz/vendor_sign-priv.git -b pos vendor/aosp/signing

# build
. build/envsetup.sh
lunch aosp_RMX1901-ap1a-userdebug
m installclean
make bacon
