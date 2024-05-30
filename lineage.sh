#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/Los-Ext/manifest.git -b lineage-21.0 --git-lfs --depth=1
git clone https://github.com/shravansayz/local_manifests.git -b los21 .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi

#customs
rm -rf frameworks/base
https://github.com/shravansayz/android_frameworks_base_los_ext.git -b lineage-21.0 frameworks/base --depth=1

#ksu
cd kernel/realme/sdm710 && curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash - && cd ../../..

#clone private keys
rm -rf .android-certs && git clone https://github.com/shravansayz/private_keys.git -b main .android-certs

# build
. build/envsetup.sh
lunch lineage_RMX1901-ap1a-userdebug
m installclean
m bacon

#crave build command
#crave run --no-patch "rm -rf lineage.sh && wget https://raw.githubusercontent.com/shravansayz/build_scripts/pos/lineage.sh && bash lineage.sh"
