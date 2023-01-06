# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= BananaDroid
include vendor/banana/config/signed.mk
include vendor/banana/config/version.mk

PRODUCT_SIZE := full

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

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

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Banana Updater permissions
PRODUCT_COPY_FILES += \
    vendor/banana/config/permissions/privapp-permissions-banana-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-banana.xml \
    vendor/banana/config/permissions/privapp-permissions-banana-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-banana-product.xml \
    vendor/banana/prebuilt/common/etc/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml \
    vendor/banana/prebuilt/common/etc/permissions/privapp-permissions-custom.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-custom.xml

# Include Banana extra packages
include vendor/banana/config/packages.mk
include vendor/banana/config/prop.mk
include vendor/extras/extras.mk

# Include Google sysconfigs
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/dialer_experience.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/google.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/google_build.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google_build.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/google_exclusives_enable.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google_exclusives_enable.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/google-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google-hiddenapi-package-whitelist.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/nexus.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/nexus.xml \
    vendor/banana/prebuilt/common/etc/sysconfig/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_2016_exclusive.xml

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

# Game Overlay
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/common/etc/sysconfig/game_overlay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/game_overlay.xml

# Quick Tap
ifeq ($(TARGET_SUPPORTS_QUICK_TAP),true)
PRODUCT_COPY_FILES += \
    vendor/banana/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml
endif

# Root
PRODUCT_PACKAGES += \
    adb_root

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/banana/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/banana/overlay/common \
    vendor/banana/overlay/no-rro

PRODUCT_PACKAGES += \
    NetworkStackOverlay

$(call inherit-product, vendor/banana/config/telephony.mk)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
