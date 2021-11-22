ATOMICBENCH_VERSION = 6d788f9adeb64ed0afaf2dae7df1fd5d4e791d84
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

