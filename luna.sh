#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b luna16 .repo/local_manifests && \
/opt/crave/resync.sh && \
export BUILD_USERNAME=shravan && \
export BUILD_HOSTNAME=crave && \
export TZ=Asia/Kolkata && \
wget https://github.com/shravansayz/local_manifests/raw/keys/keys.zip && unzip -o keys.zip -d vendor/lunaris-priv/ && rm keys.zip && \
echo ">>> Applying frameworks/base patch..." && cd frameworks/base && (git log --oneline | grep -q "dt2w\|DT2W\|double.*tap" || (wget -O temp.patch "https://github.com/shravansayz/android_frameworks_base/commit/7809e13937efaf85b319bc28d3b88326342ec1df.patch" && (git apply temp.patch && git add . && git commit -m "Apply DT2W patch" || echo "Patch conflicts detected, continuing build...") && rm -f temp.patch)) && cd ../.. && echo ">>> Frameworks/base patch process completed!" && \
. b*/env* && \
lunch lineage_RMX1901-bp2a-user && \
make installclean ; \
m lunaris
