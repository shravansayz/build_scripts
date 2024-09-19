#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init --depth=1 --no-repo-verify -u https://github.com/Los-Ext/manifest.git -b lineage-21.0 --git-lfs -g default,-mips,-darwin,-notdefault

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b ext .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh


#Private Keys
rm -rf vendor/lineage-priv
git clone https://github.com/shravansayz/private_keys.git -b rise vendor/lineage-priv

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#build
source build/envsetup.sh
lunch lineage_RMX1901-user
m installclean
m bacon
