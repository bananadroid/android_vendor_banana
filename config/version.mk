#Version of the ROM
ANDROID_VERSION := 11

BANANA_CODENAME := PisangRaja
BANANA_VERSION := v1

BANANA_BUILD_DATE := $(shell date -u +%Y-%m-%d)

ifndef BANANA_BUILDTYPE
  BANANA_BUILDTYPE := UNOFFICIAL
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst banana_,,$(TARGET_PRODUCT_SHORT))

BANANA_RELEASED_VERSION := $(ANDROID_VERSION)-$(BANANA_VERSION)-$(BANANA_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_DISPLAY_ID="$(BUILD_ID)-$(BUILD_USERNAME)@$(BUILD_HOSTNAME)"
