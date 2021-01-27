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
    Etar \
    ExactCalculator \
    Gallery2 \
    Jelly \
    OmniJaws \
    SimpleDeviceConfig \
    Snap \
    SoftAPManager \
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
    fsck.ntfs \
    mount.ntfs \
    mke2fs \
    mkfs.ntfs

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

# Fonts
PRODUCT_PACKAGES += \
    Custom-Fonts
