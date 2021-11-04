ATOMICBENCH_VERSION = 0.2
ATOMICBENCH_SITE = $(call github,plctlab,atomic_benchmark,v$(ATOMICBENCH_VERSION))
ATOMICBENCH_LICENSE = Apache-2.0
ATOMICBENCH_LICENSE_FILES = LICENSE.md

define ATOMICBENCH_BUILD_CMDS
 $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define ATOMICBENCH_INSTALL_TARGET_CMDS
 $(INSTALL) -D $(@D)/build/benchmark/$(CROSS_COMPILE)/main.bin $(TARGET_DIR)/usr/bin/atomicbench
endef

$(eval $(generic-package))

