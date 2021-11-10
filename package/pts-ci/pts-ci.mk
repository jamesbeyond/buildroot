##############################################################################
#
# pts-ci
#
################################################################################

define PTS_CI_INSTALL_TARGET_CMDS
	cp -f ./package/pts-ci/pts_run $(TARGET_DIR)/etc/init.ci/
	chmod a+x $(TARGET_DIR)/etc/init.ci/pts_run
	cp -f ./package/pts-ci/pts_parse $(HOST_DIR)/csky-ci/parse_script/
	chmod a+x $(HOST_DIR)/csky-ci/parse_script/pts_parse
endef

$(eval $(generic-package))
