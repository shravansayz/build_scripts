#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/The-Clover-Project/manifest.git -b 15-qpr1 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b clo .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
lunch clover_RMX1901-ap4a-user && \
make installclean ; \
mka clover
