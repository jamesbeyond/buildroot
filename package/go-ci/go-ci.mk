################################################################################
#
# go-ci
#
################################################################################
GO_CI_VERSION = 1.16.5

PRE_GO_INSTALL = $(HOST_DIR)/usr/local
HOST_PRE_GO_ROOT = $(PRE_GO_INSTALL)
HOST_GOBOOTSTRAP_TAR_ROOT = $(TARGET_DIR)/ci/go

GO_CI_SITE = https://storage.googleapis.com/golang
GO_CI_SOURCE = go$(GO_CI_VERSION).src.tar.gz
GO_CI_EXTRA_SOURCE = go$(GO_CI_VERSION).linux-amd64.tar.gz
GO_CI_EXTRA_DOWNLOADS = $(GO_CI_SITE)/$(GO_CI_EXTRA_SOURCE)
GO_CI_LICENSE = BSD-3-Clause
GO_CI_LICENSE_FILES = LICENSE

define GO_CI_PER_GO_EXTRACT
	mkdir -p $(PRE_GO_INSTALL)
	mkdir -p $(HOST_PRE_GO_ROOT)
	$(TAR) xf $(TOPDIR)/../dl/go-ci/$(GO_CI_EXTRA_SOURCE) -C $(HOST_PRE_GO_ROOT)
endef
GO_CI_POST_EXTRACT_HOOKS += GO_CI_PER_GO_EXTRACT

GO_CI_MAKE_ENV = \
	GOOS=linux \
	GOROOT_BOOTSTRAP="$(HOST_PRE_GO_ROOT)/go" \
	GOARCH=riscv64  \
	CGO_ENABLED=0

define GO_CI_BUILD_CMDS
	cd $(@D)/src && $(GO_CI_MAKE_ENV) ./bootstrap.bash
endef

define GO_CI_INSTALL_TARGET_CMDS
	mkdir -p $(HOST_GOBOOTSTRAP_TAR_ROOT)
	cp -f ./package/go-ci/go_run $(TARGET_DIR)/etc/init.ci/
	chmod a+x $(TARGET_DIR)/etc/init.ci/go_run
	cp -a $(@D)/../go-linux-riscv64-bootstrap.tbz $(HOST_GOBOOTSTRAP_TAR_ROOT)/
	cp $(TOPDIR)/../dl/go-ci/go$(GO_CI_VERSION).src.tar.gz  $(HOST_GOBOOTSTRAP_TAR_ROOT)/
	rm $(@D)/../go-linux-riscv64-bootstrap.tbz
	rm $(@D)/../go-linux-riscv64-bootstrap -rf
endef

$(eval $(generic-package))