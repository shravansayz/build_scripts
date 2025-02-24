#!/bin/bash

# Clean and initialize repo
echo "Initializing repository..."
rm -rf .repo/local_manifests
repo init -u https://github.com/OrionOS-Project/manifest -b vic --git-lfs
echo "Repository initialization successful!"

# Clone local manifests
echo "Cloning local manifests..."
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b orion .repo/local_manifests
echo "Local manifests cloning successful!"

# Sync repositories
echo "Syncing repositories..."
/opt/crave/resync.sh
echo "Repository sync successful!"

# Build configuration
export BUILD_USERNAME="shravan"
export BUILD_HOSTNAME="android-build"
export TZ="Asia/Kolkata"

# Setup build environment
echo "Setting up build environment..."
source build/envsetup.sh
echo "Build environment setup successful!"

# Configure build target
lunch orion_RMX1901-ap4a-user
echo "Build target configuration successful!"

# Clean build directory
echo "Cleaning build directory..."
make installclean
echo "Build directory cleaned successfully!"

# Start the build
echo "Starting build process..."
make orion
