#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b pixelage .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export PIXELAGE_BUILD=RMX1901 : \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
lunch pixelage_RMX1901-ap4a-user && \
make installclean ; \
mka bacon
