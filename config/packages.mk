# Additional packages

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Telephony
PRODUCT_PACKAGES += \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# CellBroadcastReceiver
PRODUCT_PACKAGES += \
CellBroadcastReceiver

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Additional apps
PRODUCT_PACKAGES += \
    SearchLauncherQuickStep \
    CustomDoze \
    DU-Themes \
    Etar \
    ExactCalculator \
    Gallery2 \
    Jelly \
    SimpleDeviceConfig \
    Snap \
    StitchImage \
    StitchImageService

# Extra Tools
PRODUCT_PACKAGES += \
    7z \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    setcap \
    unrar \
    zip

# FS tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mount.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs

# Permissions
PRODUCT_PACKAGES += \
    privapp-permissions-banana.xml \
    privapp-permissions-banana-product.xml \
    privapp-permissions-banana-system_ext.xml

# Exempt DeskClock from Powersave
PRODUCT_PACKAGES += \
    deskclock.xml

# Backup Services whitelist
PRODUCT_PACKAGES += \
    backup.xml

# Hidden API whitelist
PRODUCT_PACKAGES += \
    banana-hiddenapi-package-whitelist.xml

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker

PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# Flipendo
PRODUCT_PACKAGES += \
    Flipendo
