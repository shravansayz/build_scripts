#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/RisingOS-Revived/android -b fifteen --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b rise .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
riseup RMX1901 user && \
make installclean ; \
rise b
