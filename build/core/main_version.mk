# Apply it to build.prop
ADDITIONAL_BUILD_PROPERTIES += \
    ro.modversion=BananaDroid-$(BANANA_RELEASED_VERSION) \
    ro.banana.version=$(BANANA_RELEASED_VERSION) \
    ro.banana.build.version=$(BANANA_VERSION) \
    ro.banana.build_date=$(BANANA_BUILD_DATE) \
    ro.banana.displayed.version=$(BANANA_CODENAME)-$(BANANA_VERSION) \
    ro.banana.releasetype=$(BANANA_BUILDTYPE) \
    ro.build.stock_fingerprint=$(TARGET_FORCE_BUILD_FINGERPRINT)
