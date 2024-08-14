#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/The-Pixel-Project/manifest -b fourteen-qpr3 -g default,-mips,-darwin,-notdefault --git-lfs

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b tpp .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#customs
rm -rf frameworks/base
git clone https://github.com/shravansayz/frameworks_base_tpp.git -b fourteen-qpr3 frameworks/base --depth=1

rm -rf hardware/interfaces
git clone https://github.com/shravansayz/hardware_interfaces.git -b fourteen-qpr3 hardware/interfaces --depth=1

rm -rf vendor/aosp/signing
git clone https://github.com/shravansayz/private_keys.git -b pixelpro vendor/aosp/signing --depth=1

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch aosp_RMX1901-user
make installclean
make bacon
