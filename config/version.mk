# Copyright (C) 2021-2022 BananaDroid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BANANA_CODENAME = Uli
BANANA_PLATFORM_RELEASE_OR_CODENAME := 14

ifndef BANANA_BUILD_TYPE
BANANA_BUILD_TYPE := UNOFFICIAL
endif

TARGET_PRODUCT_SHORT := $(subst banana_,,$(BANANA_BUILD))

# GApps
ifeq ($(WITH_GAPPS),true)
IS_PHONE := true
$(call inherit-product-if-exists, vendor/google/gms/config.mk)
$(call inherit-product-if-exists, vendor/google/pixel/config.mk)
BANANA_EDITION := GApps
else
BANANA_EDITION := Vanilla
endif

BANANA_BUILD_DATETIME := $(shell date +%s)
BANANA_BUILD_DATE := $(shell date -u +%Y%m%d)
BANANA_DISPLAY_DATE := $(shell date -u +%Y-%m-%d)
BANANA_VERSION := BananaDroid-$(BANANA_CODENAME)-$(BANANA_BUILD)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)-$(BANANA_EDITION)
BANANA_FINGERPRINT := BananaDroid/$(BANANA_CODENAME)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BANANA_BUILD_DATE)/$(BANANA_EDITION)
BANANA_DISPLAY_VERSION := BananaDroid-$(BANANA_CODENAME)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)-$(BANANA_EDITION)

PRODUCT_GENERIC_PROPERTIES += \
  ro.banana.version=$(BANANA_VERSION) \
  ro.banana.releasetype=$(BANANA_BUILD_TYPE) \
  ro.modversion=$(BANANA_CODENAME) \
  ro.banana.build.date=$(BANANA_BUILD_DATETIME)\
  ro.banana.display.date=$(BANANA_DISPLAY_DATE)\
  ro.banana.display.version=$(BANANA_DISPLAY_VERSION) \
  ro.banana.fingerprint=$(BANANA_FINGERPRINT)\
  ro.banana.edition=$(BANANA_EDITION)\
  ro.banana.settings.android_version=$(BANANA_PLATFORM_RELEASE_OR_CODENAME)
