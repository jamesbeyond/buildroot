##############################################################################
#
# pts-ci
#
################################################################################

define PTS_CI_INSTALL_TARGET_CMDS
	cp -f ./package/pts-ci/pts_run $(TARGET_DIR)/etc/init.ci/
	chmod a+x $(TARGET_DIR)/etc/init.ci/pts_run
endef

$(eval $(generic-package))
