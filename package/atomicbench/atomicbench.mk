ATOMICBENCH_VERSION = f638d157c6d05925a8627b1a02017d8be28f967b
ATOMICBENCH_SITE = $(call github,GeassCore,atomicbench,$(ATOMICBENCH_VERSION))
ATOMICBENCH_LICENSE = Apache-2.0
ATOMICBENCH_LICENSE_FILES = LICENSE.md

define ATOMICBENCH_BUILD_CMDS
 $(TARGET_MAKE_ENV) CROSS_COMPILE=$(notdir $(TARGET_CROSS:%-=%)) $(MAKE) -C $(@D)
endef

define ATOMICBENCH_INSTALL_TARGET_CMDS
 $(INSTALL) -D $(@D)/build/benchmark/$(notdir $(TARGET_CROSS:%-=%))/main.bin $(TARGET_DIR)/usr/bin/atomicbench
endef

$(eval $(generic-package))

