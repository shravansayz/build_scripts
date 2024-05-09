#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/StatiXOS/android_manifest.git -b udc-qpr2 --git-lfs --depth=1
git clone https://github.com/shravansayz/local_manifests.git -b test .repo/local_manifests
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

#ksu
cd kernel/realme/sdm710 && curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash - && cd ../../..

# build
/opt/crave/resync.sh
. build/envsetup.sh
brunch statix_RMX1901-ap1a-user
