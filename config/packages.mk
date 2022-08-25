# BananaDroid packages
PRODUCT_PACKAGES += \
    GameSpace \
    Recorder \
    NoCutoutOverlay \
    OmniJaws \
    AvoidAppsInCutoutOverlay \
    SettingsIntelligenceGoogle \
    RepainterServicePriv

ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGES += \
    BananaThemesStub \
    ExactCalculator \
    ThemePicker \
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

# Lawnchair
TARGET_BUILD_LAWNCHAIR ?= true
ifeq ($(strip $(TARGET_BUILD_LAWNCHAIR)),true)
include vendor/lawnchair/lawnchair.mk
endif

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
