#!/bin/bash

rm -rf .repo/local_manifests && \
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-22.1 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b los22 .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
lunch lineage_RMX1901-ap4a-user && \
make installclean ; \
mka bacon
