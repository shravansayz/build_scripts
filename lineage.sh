#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b los21 .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/android_frameworks_base_los21.git -b lineage-21.0 frameworks/base --depth=1

#Private Keys
rm -rf vendor/lineage-priv
git clone https://github.com/shravansayz/private_keys.git -b los21 vendor/lineage-priv

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch lineage_RMX1901-ap2a-user
m installclean
m bacon
