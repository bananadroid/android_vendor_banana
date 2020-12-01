PRODUCT_BRAND ?= BananaDroid
BANANA_BUILD := true

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

# Additional packages
-include vendor/banana/config/packages.mk

# Versioning
-include vendor/banana/config/version.mk

# Themes and Theme overlays
include vendor/themes/themes.mk

# Add our overlays
DEVICE_PACKAGE_OVERLAYS += vendor/themes/overlay/common

# Exclude from RRO
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/themes/overlay

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/banana/themes/dictionaries

# Squisher Location
SQUISHER_SCRIPT := vendor/banana/tools/squisher

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
