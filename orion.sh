#!/bin/bash

# Exit on error
set -e

# Build configuration
export BUILD_USERNAME="shravan"
export BUILD_HOSTNAME="android-build"
export TZ="Asia/Kolkata"

# Clean and initialize repo
echo "Initializing repository..."
rm -rf .repo/local_manifests
repo init -u https://github.com/OrionOS-Project/manifest -b vic --git-lfs

# Clone local manifests
echo "Cloning local manifests..."
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b orion .repo/local_manifests

# Sync repositories
echo "Syncing repositories..."
/opt/crave/resync.sh

# Pull LFS objects with error handling
echo "Pulling LFS objects..."
repo forall -c 'git lfs pull || echo "LFS pull failed for $REPO_PATH"'

# Setup build environment
echo "Setting up build environment..."
source build/envsetup.sh

# Configure build target
lunch orion_RMX1901-ap4a-user

# Clean build directory
echo "Cleaning build directory..."
make installclean

# Start the build
echo "Starting build process..."
make orion
