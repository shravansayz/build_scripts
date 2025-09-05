#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/CherishOS/android_manifest.git -b sixteen && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b cherish .repo/local_manifests && \
/opt/crave/resync.sh && \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=crave ; \
export TZ=Asia/Kolkata ; \
wget https://github.com/shravansayz/local_manifests/raw/keys/keys.zip && unzip -o keys.zip -d vendor/cherish-priv/ && rm keys.zip && \
source build/envsetup.sh && \
make installclean ; \
brunch RMX1901 user
