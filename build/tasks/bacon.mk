# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
# Copyright (C) 2021 BananaDroid
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

ifneq ($(BUILD_WITH_COLORS),0)
    include $(TOP_DIR)vendor/banana/build/core/colors.mk
endif

BANANA_TARGET_PACKAGE := $(PRODUCT_OUT)/$(BANANA_VERSION).zip
MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: bacon banana
bacon: $(INTERNAL_OTA_PACKAGE_TARGET) \
       $(INTERNAL_OTATOOLS_FILES)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(BANANA_TARGET_PACKAGE)
	$(hide) $(MD5) $(BANANA_TARGET_PACKAGE) > $(BANANA_TARGET_PACKAGE).md5sum
ifeq ($(BANANA_BUILD_TYPE), OFFICIAL)
	@echo "Creating json OTA..."
	$(hide) ./vendor/banana/tools/generate_json_build_info.sh $(BANANA_TARGET_PACKAGE)
endif
	@echo -e ""
	@echo -e ${CL_YLW}"       ▄▄▄▄    ▄▄▄      ▄▄▄▄   ▄  ▄▄▄      ▄▄▄▄   ▄  ▄▄▄          "${CL_YLW}
	@echo -e ${CL_YLW}"      ▓█████▄ ▒████▄   ▓█████▄ ██▒████▄   ▓█████▄ ██▒████▄        "${CL_YLW}
	@echo -e ${CL_YLW}"      ▒██▒ ▄██▒██  ▀█▄ ▒██  ▀█▄██▒██  ▀█▄ ▒██  ▀█▄██▒██  ▀█▄      "${CL_YLW}
	@echo -e ${CL_YLW}"      ▒██░█▀  ░██▄▄▄▄██▒██░   ███░██▄▄▄▄██▒██░   ███░██▄▄▄▄██     "${CL_YLW}
	@echo -e ${CL_YLW}"      ▓█  ▀█▓░▓█   ▓██▒▓█     ▓██▒█   ▓██▒▓█     ▓██▒█   ▓██▒     "${CL_YLW}
	@echo -e ${CL_YLW}"      ▓███▀▒░░▒   ▓▒█░ ▒      ▒█░▒   ▓▒█░ ▒      ▒█░▒   ▓▒█░      "${CL_YLW}
	@echo -e ${CL_YLW}"      ▒   ░  ░▒   ▒▒ ░ ▒      ▒░ ▒   ▒▒ ░ ▒      ▒░ ▒   ▒▒ ░      "${CL_YLW}
	@echo -e ${CL_YLW}"	 ░       ░   ▒    ░      ░  ░   ▒    ░      ░  ░   ▒         "${CL_YLW}
	@echo -e ""
	@echo -e ${CL_YLW}"                        Your Banana is ready!                     "${CL_YLW}
	@echo ""
	@echo -e ${CL_CYN}"Package zip  : "${CL_MAG} $(BANANA_TARGET_PACKAGE)                                 ${CL_RST}
	@echo -e ${CL_CYN}"Package md5  : "${CL_MAG}" `cat $(BANANA_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"${CL_RST}
	@echo -e ${CL_CYN}"Package size : "${CL_MAG}" `du -h $(BANANA_TARGET_PACKAGE) | cut -f 1`            "${CL_RST}
	@echo -e ""

banana: bacon
