#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/DerpFest-AOSP/android_manifest.git -b 16 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b derp16 .repo/local_manifests && \
/opt/crave/resync.sh && \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=crave ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
lunch lineage_RMX1901-bp2a-user && \
make installclean ; \
mka derp
