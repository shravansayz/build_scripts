rm -rf .repo/local_manifests/ 

# Clone DerpFest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --depth=1

# Clone local_manifests repository
git clone https://github.com/shravansayz/local_manifests --depth 1 -b derp14 .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/shravansayz/local_manifests.git
 fi

# repo sync
/opt/crave/resync.sh

source build/envsetup.sh

# brunch configuration
lunch derp_RMX1901-user

# Clean
make installclean

# Run
mka derp
