ATOMICBENCH_VERSION = d9a176ab2a575a6bc3cdb0a456b9057e50916c5b
ATOMICBENCH_SITE = $(call github,plctlab,atomic-benchmark,$(ATOMICBENCH_VERSION))
ATOMICBENCH_LICENSE = Apache-2.0
ATOMICBENCH_LICENSE_FILES = LICENSE.md

define ATOMICBENCH_BUILD_CMDS
 $(TARGET_MAKE_ENV) CROSS_COMPILE=$(notdir $(TARGET_CROSS:%-=%)) $(MAKE) -C $(@D)
endef

define ATOMICBENCH_INSTALL_TARGET_CMDS
 $(INSTALL) -D $(@D)/build/benchmark/$(notdir $(TARGET_CROSS:%-=%))/main.bin $(TARGET_DIR)/usr/bin/atomicbench
endef

$(eval $(generic-package))

