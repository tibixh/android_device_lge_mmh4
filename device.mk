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

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Recovery init
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/init.recovery.mt6765.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mmh4.rc

# Init
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/etc/init.mt6765.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mt6765.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mt6765_core.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mt6765_core.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmh4.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mmh4.rc \
    $(LOCAL_PATH)/rootdir/etc/init.lge.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.lge.usb.rc \
    $(LOCAL_PATH)/rootdir/etc/init.lge.usb.configfs.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/iinit.lge.usb.configfs.rc

# Ueventd
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/ueventd.mmh4.rc:$(TARGET_COPY_OUT_ROOT)/ueventd.mmh4.rc

## TODO: fix recovery init for patching ro.hardware before init

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.0-impl-2.1

# Configstore
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.composer@2.1-resources \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    libdrm.vendor \
    libhwc2on1adapter \
    libhwc2onfbadapter \
    libvulkan

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl:64 \
    android.hardware.drm@1.0-service-lazy \
    android.hardware.drm@1.3-service.clearkey

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    android.hidl.memory.block@1.0


# Audio
PRODUCT_COPY_FILES += \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
	frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Display
TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1440

# Call proprietary blob setup
$(call inherit-product-if-exists, vendor/lge/mmh4/mmh4-vendor.mk)