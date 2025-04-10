#
# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Gboard Props
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# GMS Props
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# GMS RRO overlay
PRODUCT_PACKAGES += \
    GoogleSettingsOverlay

# Google Battery
TARGET_DOES_NOT_SUPPORT_GOOGLE_BATTERY ?= true

# Include TurboAdapter without Google Battery support
ifeq ($(TARGET_DOES_NOT_SUPPORT_GOOGLE_BATTERY),true)
PRODUCT_PACKAGES += \
    TurboAdapter_NoBatt \
    libpowerstatshaldataprovider \
    libpowerstatshaldataprovider_libpowerstatshaldataprovider_symlink64
endif

# SetupWizard Props
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.enable_quick_start_flow=true \
    setupwizard.feature.enable_restore_anytime=true \
    setupwizard.feature.enable_wifi_tracker=true \
    setupwizard.feature.lifecycle_refactoring=true \
    setupwizard.feature.notification_refactoring=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.personal_safety_suw_enabled=true

$(call inherit-product, vendor/gms/common/common-vendor.mk)
