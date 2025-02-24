#!/bin/bash

echo "
▸ ORION OS Hydroxide
  ❯ Based on Android 15
  ❯ Target: RMX1901 [Realme X]
  ❯ Variant: User Build
  ❯ Builder: $BUILD_USERNAME
  ❯ $(date +%d-%m-%Y\ %H:%M:%S)
▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾▾"

# Clean and initialize repo
echo "
[1/7] » Preparing workspace..."
rm -rf .repo/local_manifests
repo init -u https://github.com/OrionOS-Project/manifest -b vic --git-lfs
echo "STATUS ❯ Repository Initialized ✓"

# Clone local manifests
echo "
[2/7] » Setting up manifests..."
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b orion .repo/local_manifests
echo "STATUS ❯ Manifests Connected ✓"

# Sync repositories
echo "
[3/7] » Syncing source tree..."
/opt/crave/resync.sh
echo "STATUS ❯ Source Synchronized ✓"

# Build configuration
export BUILD_USERNAME="shravan"
export BUILD_HOSTNAME="android-build"
export TZ="Asia/Kolkata"

# Setup build environment
echo "
[4/7] » Loading build tools..."
source build/envsetup.sh
echo "STATUS ❯ Environment Active ✓"

# Configure build target
echo "
[5/7] » Configuring device..."
lunch orion_RMX1901-ap4a-user
echo "STATUS ❯ Target Configured ✓"

# Clean build directory
echo "
[6/7] » Cleaning build space..."
make installclean
echo "STATUS ❯ Workspace Ready ✓"

# Start the build
echo "
[7/7] » Launching build process..."
make orion
echo "
▸ BUILD SEQUENCE INITIATED
  ❯ Started at: $(date +%H:%M:%S)
  ❯ Codename: Hydroxide
  ❯ Device: RMX1901
  
  < Building OrionOS with ⚡ >
▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴"
