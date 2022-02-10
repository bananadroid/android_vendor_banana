# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= BananaDroid
include vendor/banana/config/version.mk

PRODUCT_SIZE := full

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-superior.sh

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/banana/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/banana/prebuilt/common/bin/50-banana.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-banana.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/banana/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/banana/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/banana/config/permissions/backup.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/backup.xml

# Copy all Banana-specific init rc files
$(foreach f,$(wildcard vendor/banana/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/banana/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Banana Updater permissions
PRODUCT_COPY_FILES += \
    vendor/banana/config/permissions/privapp-permissions-banana-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-banana.xml

# Log privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Include Banana extra packages
include vendor/banana/config/packages.mk
include vendor/extras/extras.mk

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/banana/overlay/dictionaries

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# ART
# Optimize everything for preopt
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
# Don't preopt prebuilts
DONT_DEXPREOPT_PREBUILTS := true

ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
# Use 64-bit dex2oat for better dexopt time.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot=verify \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.install=speed-profile \
    pm.dexopt.bg-dexopt=everything

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.ab-ota=quicken
endif

# Faceunlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Root
PRODUCT_PACKAGES += \
    adb_root

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.theme=glif_v3_light

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/banana/overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/banana/overlay/common

$(call inherit-product, vendor/banana/config/telephony.mk)

# rro_overlays
$(call inherit-product, vendor/banana/config/rro_overlays.mk)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
