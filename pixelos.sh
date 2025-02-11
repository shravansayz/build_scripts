#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://gitlab.com/ThankYouHonami/manifest.git -b fifteen --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b pixel .repo/local_manifests && \
/opt/crave/resync.sh && \
repo forall -c 'git lfs pull' ; \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=android-build ; \
export TZ=Asia/Kolkata ; \
source build/envsetup.sh && \
breakfast RMX1901 user && \
make installclean ; \
mka bacon && wget https://raw.githubusercontent.com/shravansayz/go-up/master/go-up && chmod +x go-up && ./go-up out/target/product/RMX1901/PixelOS*.zip
