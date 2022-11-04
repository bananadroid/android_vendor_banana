#
# Copyright (C) 2021-2022 The xdroidOSS && Prjkt
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
#

OFFICIAL_MAINTAINER = $(shell cat official-maintainers/maintainers.list | awk '{ print $$1 }')

ifdef BANANA_MAINTAINER
ifeq ($(filter $(BANANA_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(BANANA_MAINTAINER))
    BANANA_BUILD_TYPE := OFFICIAL
else
$(warning "Unofficial maintainer detected, building as unofficial build.")
endif
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.banana.maintainer=$(BANANA_MAINTAINER)
else
$(warning "No maintainer name detected, building as unofficial build.")
endif 
