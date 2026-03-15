#
# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/lge/mmh4

# Platform
TARGET_BOARD_PLATFORM := mt6765
TARGET_BOOTLOADER_BOARD_NAME := mt6765
TARGET_NO_BOOTLOADER := true

# Treble
BOARD_VNDK_VERSION  := current
PRODUCT_EXTRA_VNDK_VERSIONS := 28
TARGET_COPY_OUT_VENDOR := vendor

AB_OTA_UPDATER := true

TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic

# Kernel
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
# TARGET_KERNEL_SOURCE := kernel/lge/mt6765
# TARGET_KERNEL_CONFIG := mmh4x_defconfig
# BOARD_KERNEL_IMAGE_NAME := zImage-dtb

BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x40000000
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x11b00000 --second_offset 0x00f00000 --tags_offset 0x07880000 --dt $(DEVICE_PATH)/prebuilt/dt.img

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,32N2 
BOARD_KERNEL_CMDLINE += androidboot.mode=recovery
BOARD_KERNEL_CMDLINE += androidboot.usbconfigfs=true
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive 

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 22124429312
BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912

AB_OTA_PARTITIONS := \
    boot \
    system \
    vendor \
    odmdtbo \
    vbmeta

# MediaTek
BOARD_HAS_MTK_HARDWARE := true

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# TWRP Specifics
TW_THEME := portrait_hdpi
TW_INCLUDE_CRYPTO := true
