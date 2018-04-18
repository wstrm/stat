################################################################################
#
# stat-webview
#
################################################################################

STAT_WEBVIEW_VERSION = 4dd400b8a1cb4d60ca8a7167025b0f19e78d134b
STAT_WEBVIEW_SITE = https://github.com/willeponken/stat-webview.git
STAT_WEBVIEW_SITE_METHOD = git
STAT_WEBVIEW_DEPENDENCIES = qt5webengine
STAT_WEBVIEW_LICENSE = MIT
STAT_WEBVIEW_LICENSE_FILES = LICENSE
STAT_WEBVIEW_WEPAGE = $(call qstrip,$(BR2_PACKAGE_STAT_WEBVIEW_WEBPAGE))

define STAT_WEBVIEW_CONFIGURE_WEBPAGE
	sed -i "s|https://example.org|$(BR2_PACKAGE_STAT_WEBVIEW_WEBPAGE)|" $(@D)/main.cpp
endef

define STAT_WEBVIEW_CONFIGURE_CMDS
	$(STAT_WEBVIEW_CONFIGURE_WEBPAGE)
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) PREFIX=/usr)
endef

define STAT_WEBVIEW_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define STAT_WEBVIEW_INSTALL_TARGET_CMDS
	cp -dpf $(@D)/stat-webview $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
