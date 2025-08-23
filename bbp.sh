#!/bin/bash

# Exit immediately on error
set -e

# =========[ 1. CLEAN LOCAL MANIFESTS ]=========
echo "🧹 Cleaning up local manifests..."
rm -rf .repo/local_manifests

# =========[ 2. INITIALIZE REPO ]=========
echo "📥 Initializing repo..."
repo init -u https://github.com/AxionAOSP/android.git -b lineage-23.0 --git-lfs

# =========[ 3. CLONE LOCAL MANIFESTS ]=========
echo "🔁 Cloning local manifests..."
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b axion .repo/local_manifests

# =========[ 4. SYNC SOURCE ]=========
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# =========[ 5. PULL GIT LFS FILES ]=========
echo "📦 Pulling LFS files..."
repo forall -c 'git lfs pull'

# =========[ 6. SET ENVIRONMENT VARIABLES ]=========
export BUILD_USERNAME=shravan
export BUILD_HOSTNAME=android-build
export TZ=Asia/Kolkata

# =========[ 7. SETUP BUILD ENVIRONMENT ]=========
echo "🧰 Setting up build environment..."
source build/envsetup.sh

# =========[ 8. START BUILD ]=========
echo "⚙️ Starting build for RMX1901 (GMS Pico)..."
axion RMX1901 gms pico

# =========[ 9. CLEAN INSTALL ARTIFACTS ]=========
echo "🧼 Cleaning up install artifacts..."
make installclean

# =========[ 10. EXECUTE ax -br ]=========
echo "📦 Running axion..."
ax -br

# =========[ 11. FIND ZIP AND UPLOAD TO GOFILE ]=========
echo "🔍 Locating output ZIP..."
ROM_ZIP=$(find out/target/product/RMX1901 -type f -name "*.zip" | head -n 1)

if [[ ! -f "$ROM_ZIP" ]]; then
    echo "❌ ERROR: ROM build failed or output ZIP not found."
    exit 1
fi

echo "✅ ROM build complete: $ROM_ZIP"

# =========[ 12. UPLOAD TO GOFILE ]=========
echo "🚀 Uploading to GoFile.io..."
SERVER_JSON=$(curl -s https://api.gofile.io/getServer)
UPLOAD_SERVER=$(echo "$SERVER_JSON" | grep -oP '(?<="server":")[^"]+')

UPLOAD_RESPONSE=$(curl -s -F "file=@$ROM_ZIP" "https://$UPLOAD_SERVER.gofile.io/uploadFile")
DOWNLOAD_LINK=$(echo "$UPLOAD_RESPONSE" | grep -oP '(?<="downloadPage":")[^"]+')

if [[ -n "$DOWNLOAD_LINK" ]]; then
    echo "✅ Upload successful!"
    echo "🔗 Download link: $DOWNLOAD_LINK"
else
    echo "❌ Upload failed. Full response:"
    echo "$UPLOAD_RESPONSE"
    exit 1
fi
