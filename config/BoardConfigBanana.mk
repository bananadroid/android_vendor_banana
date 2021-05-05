include vendor/banana/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/banana/config/BoardConfigQcom.mk
endif

include vendor/banana/config/BoardConfigSoong.mk
