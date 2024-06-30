#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b pos14 .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_pos.git -b fourteen frameworks/base --depth=1

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave
subject='/C=IN/ST=Haryana/L=Panipat/O=Android/OU=Android/CN=Android/emailAddress=shravansayz@gmail.com'
for x in releasekey platform shared media networkstack nfc verity otakey testkey sdk_sandbox bluetooth; do \
  echo '' |./development/tools/make_key vendor/aosp/signing/keys/$x "$subject"; \
done

#build
source build/envsetup.sh
lunch aosp_RMX1901-ap2a-userdebug
make installclean
mka bacon

