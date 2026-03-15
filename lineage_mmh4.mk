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

# Release name
PRODUCT_RELEASE_NAME := LG K40

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Insecure adb
ifneq ($(TARGET_BUILD_VARIANT),eng)
    PRODUCT_PROPERTY_OVERRIDES += \
	ro.secure=0 \
	ro.adb.secure=0 \
	ro.debuggable=1 \
	persist.service.adb.enable=1
endif

# Init
PRODUCT_PACKAGES += \
    fstab.enableswap \
    init.target.rc \
    init.recovery.mmh4.rc \
	init.recovery.mt6765.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Device identifier.
PRODUCT_DEVICE := mmh4
PRODUCT_NAME := lineage_mmh4
PRODUCT_BRAND := LGE
PRODUCT_MODEL := LM-X420
PRODUCT_MANUFACTURER := LGE
PRODUCT_CHARACTERISTICS := phone