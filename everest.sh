#!/bin/bash

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=codespace
# init and sync
rm -rf .repo/local_manifests
repo init -u https://github.com/ProjectEverest/android_manifest -b qpr2 --git-lfs
git clone https://github.com/shravansayz/local_manifests.git -b everest .repo/local_manifests
/opt/crave/resync.sh

# build rom
source build/envsetup.sh
lunch everest_RMX1901-userdebug
m installclean
mka bacon

# crave build command
# crave run --no-patch "rm -rf everest.sh && wget https://raw.githubusercontent.com/shravansayz/scripts/main/everest.sh && chmod +x everest.sh && bash everest.sh"
