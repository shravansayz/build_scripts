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
» Preparing workspace..."
rm -rf .repo/local_manifests
repo init -u https://github.com/OrionOS-Project/manifest -b vic --git-lfs
echo "STATUS ❯ Repository Initialized ✓"

# Clone local manifests
echo "
» Setting up manifests..."
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b orion .repo/local_manifests
echo "STATUS ❯ Manifests Connected ✓"

# Sync repositories
echo "
» Syncing source tree..."
/opt/crave/resync.sh
echo "STATUS ❯ Source Synchronized ✓"

# Cherry-pick commit
echo "
» Cherry-picking required commit..."
cd frameworks/base
git fetch https://github.com/OrionOS-Project/frameworks_base 
git cherry-pick 

# Check if cherry-pick was successful
if [ $? -eq 0 ]; then
    echo "STATUS ❯ Commit Successfully Cherry-picked ✓"
else
    echo "STATUS ❯ Cherry-pick Failed! Resolving conflicts required ✗"
    echo "NOTE: Please resolve conflicts manually, then run 'git cherry-pick --continue'"
    exit 1
fi

# Return to root directory
cd ../../

# Build configuration
export BUILD_USERNAME="shravan"
export BUILD_HOSTNAME="android-build"
export TZ="Asia/Kolkata"

# Setup build environment
echo "
» Loading build tools..."
source build/envsetup.sh
echo "STATUS ❯ Environment Active ✓"

# Configure build target
echo "
» Configuring device..."
lunch orion_RMX1901-ap4a-user
echo "STATUS ❯ Target Configured ✓"

# Clean build directory
echo "
» Cleaning build space..."
make installclean
echo "STATUS ❯ Workspace Ready ✓"

# Start the build
echo "
» Launching build process..."
make orion

echo "
▸ BUILD SEQUENCE COMPLETED
  ❯ Device: RMX1901
  
  < Building OrionOS >
▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴▴"
