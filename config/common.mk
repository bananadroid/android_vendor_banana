PRODUCT_BRAND ?= BananaDroid
BANANA_BUILD := true

TARGET_FORCE_BUILD_FINGERPRINT := google/redfin/redfin:11/RQ3A.210905.001/7511028:user/release-keys

# Inherit art options
include vendor/banana/config/art.mk

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Fixes: terminate called after throwing an instance of 'std::out_of_range' what(): basic_string::erase
# error with prop override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# general properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.opa.eligible_device=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/banana/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/banana/prebuilt/bin/50-hosts.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-hosts.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/banana/prebuilt/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/banana/prebuilt/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Copy all Banana-specific init rc files
$(foreach f,$(wildcard vendor/banana/prebuilt/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy BananaDroid additional files
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/etc/permissions/privapp-permissions-banana.xml:$(TARGET_COPY_OUT_ETC)/permissions/privapp-permissions-banana.xml \
    vendor/banana/prebuilt/etc/permissions/privapp-permissions-banana-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-banana-product.xml \
    vendor/banana/prebuilt/etc/permissions/privapp-permissions-banana-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-banana-system_ext.xml \
    vendor/banana/prebuilt/etc/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml \
    vendor/banana/prebuilt/google/etc/sysconfig/pixel_experience_2020.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2020.xml

# Weather
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/etc/default-permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/com.android.providers.weather.xml \
    vendor/banana/prebuilt/etc/permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.android.providers.weather.xml

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/etc/sysconfig/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Telephony
$(call inherit-product, vendor/banana/config/telephony.mk)

# GApps version
ifeq ($(GAPPS_VERSION),true)
$(call inherit-product, vendor/google/gms/config.mk)
DONT_DEXPREOPT_PREBUILTS := true
else
# Use default filter for problematic AOSP apps.
PRODUCT_DEXPREOPT_QUICKEN_APPS += \
    Dialer
endif # GApps version

# Additional packages
-include vendor/banana/config/packages.mk

# Versioning
-include vendor/banana/config/version.mk

# Themes and overlays
include vendor/extras/themes.mk
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/banana/overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/banana/overlay/common \
    vendor/banana/overlay/dictionaries

# Squisher Location
SQUISHER_SCRIPT := vendor/banana/tools/squisher

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.sys.sf.disable_blurs=0 \
    ro.sf.blurs_are_expensive=0 \
    ro.surface_flinger.supports_background_blur=1

# This needs to be specified explicitly to override ro.apex.updatable=true from
# prebuilt vendors, as init reads /product/build.prop after /vendor/build.prop
PRODUCT_PRODUCT_PROPERTIES += ro.apex.updatable=false

# Dex optimization
USE_DEX2OAT_DEBUG := false
WITH_DEXPREOPT_DEBUG_INFO := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

# Fix for missing aeabi symbols on old blobs
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v29/arm64/arch-arm-armv8-a/shared/vndk-sp/libcompiler_rt.so:vendor/lib/libcompiler_rt.so \
    prebuilts/vndk/v29/arm64/arch-arm64-armv8-a/shared/vndk-sp/libcompiler_rt.so:vendor/lib64/libcompiler_rt.so

# Use 64-bit dex2oat for better dexopt time
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# Treble
# Enable ALLOW_MISSING_DEPENDENCIES on Vendorless Builds
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
  ALLOW_MISSING_DEPENDENCIES := true
endif

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),eng)
SELINUX_IGNORE_NEVERALLOWS := true
endif
