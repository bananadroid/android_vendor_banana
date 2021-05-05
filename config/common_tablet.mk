# Common settings and files
-include vendor/banana/config/common.mk

# Add tablet overlays
DEVICE_PACKAGE_OVERLAYS += vendor/banana/overlay/common_tablet

PRODUCT_CHARACTERISTICS := tablet
