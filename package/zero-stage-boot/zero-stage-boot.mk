##############################################################################
#
# zero-stage-boot
#
##############################################################################

ZERO_STAGE_BOOT_VERSION = 0b08c1d93e3bbebfaad9e6901be558be437c66b2
ZERO_STAGE_BOOT_SOURCE = zero_stage_boot-$(ZERO_STAGE_BOOT_VERSION).tar.gz
ZERO_STAGE_BOOT_SITE = $(call github,T-head-Semi,zero_stage_boot,$(ZERO_STAGE_BOOT_VERSION))

define ZERO_STAGE_BOOT_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) $(MAKE) -C $(@D)
endef

$(eval $(generic-package))
