#!/bin/bash

# Remove old local_manifests
rm -rf .repo/local_manifests
rm -rf device/xiaomi/mojito
rm -rf vendor/xiaomi/mojito
rm -rf kernel/xiaomi/mojito
rm -rf packages/modules/Bluetooth

# Local TimeZone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

# ROM source repo
repo init -u https://github.com/baikalos/android.git -b 13.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone -b baikal https://github.com/Baikal-OS/local_manifests .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Custom android_packages_modules_Bluetooth
rm -rf packages/modules/Bluetooth
git clone -b 13.0 https://github.com/Baikal-OS/android_packages_modules_Bluetooth.git packages/modules/Bluetooth

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME="Sachin"
export BUILD_HOSTNAME="crave"
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_mojito-userdebug
echo "============="

# Make clean install
make installclean
echo "============="

# Build ROM
m bacon
