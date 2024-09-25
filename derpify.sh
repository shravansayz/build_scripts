#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 15

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b test  .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh && /opt/crave/resync.sh

export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=crave

#Clean existing hals
rm -rf hardware/qcom-caf/sdm845

#Audio hal
git clone https://github.com/LineageOS/android_hardware_qcom_audio.git -b lineage-21.0-caf-sdm845 hardware/qcom-caf/sdm845/audio

#Display hal
git clone https://github.com/LineageOS/android_hardware_qcom_display.git -b lineage-21.0-caf-sdm845 hardware/qcom-caf/sdm845/display

#Media hal
git clone https://github.com/LineageOS/android_hardware_qcom_media.git -b lineage-21.0-caf-sdm845 hardware/qcom-caf/sdm845/media


# Git-lfs
repo forall -c 'git lfs install && git lfs pull'

# Set up build environment
source build/envsetup.sh
lunch derp_RMX1901-userdebug
make installclean
mka derp
