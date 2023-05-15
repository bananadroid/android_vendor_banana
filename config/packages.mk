# BananaDroid packages
PRODUCT_PACKAGES += \
    Aperture \
    BananaPaper \
    Etar \
    ExactCalculator \
    GameSpace \
    OmniJaws \
    Recorder \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay \
    ParallelSpace \
    RepainterServicePriv \
    SettingsIntelligenceGoogle \
    SetupWizard \
    ThemePicker \
    ThemesStub \
    TurboAdapter \
    TurboPrebuilt \
    Launcher3QuickStep

ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGES += \
    TrichromeLibrary \
    TrichromeWebView \
    TrichromeChrome
endif

ifeq ($(BANANA_BUILD_TYPE),OFFICIAL)
PRODUCT_PACKAGES += \
    Updates
endif

ifneq ($(TARGET_EXCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

# TouchGestures
TARGET_SUPPORTS_TOUCHGESTURES ?= false
ifeq ($(TARGET_SUPPORTS_TOUCHGESTURES),true)
PRODUCT_PACKAGES += \
    TouchGestures \
    TouchGesturesSettingsOverlay
endif

# Build
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Extra tools in BananaDroid
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# TextClassifier
PRODUCT_PACKAGES += \
	libtextclassifier_annotator_en_model \
	libtextclassifier_annotator_universal_model \
	libtextclassifier_actions_suggestions_universal_model \
	libtextclassifier_lang_id_model

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif
