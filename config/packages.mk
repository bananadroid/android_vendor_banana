# BananaDroid packages
PRODUCT_PACKAGES += \
    GameSpace \
    Recorder \
    NoCutoutOverlay \
    OmniJaws \
    AvoidAppsInCutoutOverlay \
    SettingsIntelligenceGoogle \
    ThemePicker \
    Launcher3QuickStep \
    Lawnicons \
    RepainterServicePriv

ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGES += \
    ExactCalculator \
    SimpleCalendar \
    SimpleGallery
endif

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
