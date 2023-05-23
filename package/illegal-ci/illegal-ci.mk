##############################################################################
#
#  python3-ci
#
################################################################################

#OPENJDK_SPECJVM_VERSION = 2008_1_01
#OPENJDK_SPECJVM_SITE = http://spec.cs.miami.edu/downloads/osg/java
#OPENJDK_SPECJVM_SOURCE = SPECjvm$(OPENJDK_SPECJVM_VERSION)_setup.jar
#OPENJDK_CI_EXTRA_DOWNLOADS=$(OPENJDK_SPECJVM_SITE)/$(OPENJDK_SPECJVM_SOURCE)

ILLEGAL_CI_ROOT = $(TARGET_DIR)/../build/illegal_inst_test

define PYTHON3_CI_INSTALL_TARGET_CMDS
	mkdir -p $(ILLEGAL_CI_ROOT)
	cd $(ILLEGAL_CI_ROOT)
	echo "xxxxx"
	
endef

$(eval $(generic-package))
