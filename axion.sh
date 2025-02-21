#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/AxionAOSP/android.git -b lineage-22.1 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b axion .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
make installclean ; \
axion RMX1901
