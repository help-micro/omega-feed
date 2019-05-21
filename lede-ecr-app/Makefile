include $(TOPDIR)/rules.mk

PKG_NAME:=lede-ecr-app
PKG_VERSION:=1.0.70
PKG_RELEASE:=2
PKG_REV:=HEAD
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.gz
PKG_MIRROR_HASH:=bbcf70f8b0a64fc631e2a62526d9270e3c49b52c7427c11983618931a03ae643
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)


PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/help-micro/omega-lede-ecr-app.git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/lede-ecr-app
	CATEGORY:=ECR
	SECTION:=ECR
	TITLE:=ECR proxy app
	DEPENDS:=+uci +firewall +nodejs +bluez-daemon
endef


define Package/lede-ecr-app/description
Application to forward requests from external port to ECR
endef

define Build/Compile
        $(CP) ./files/Makefile $(PKG_BUILD_DIR)/Makefile
endef

define Package/lede-ecr-app/conffiles
/etc/config/firewall
endef

define Package/lede-ecr-app/install
	# copy the web site files
	$(INSTALL_DIR) $(1)/www $(1)/usr/share/lede-ecr-util
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/etc/hotplug.d
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(INSTALL_DIR) $(1)/etc/hotplug.d/block
	$(INSTALL_DIR) $(1)/etc/bluetooth
	$(INSTALL_DIR) $(1)/home/ftp_user
	$(INSTALL_DIR) $(1)/home/ftp_user/storage
	$(INSTALL_DIR) $(1)/etc/dbus-1/system.d/
	$(INSTALL_DIR) $(1)/root
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DIR) $(1)/lib/functions
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/init.d/ecr $(1)/etc/init.d/ecr
	$(INSTALL_BIN) ./files/checkWanStatus.sh $(1)/usr/share/lede-ecr-util/checkWanStatus
	$(INSTALL_BIN) ./files/wanStatus $(1)/etc/init.d/wanStatus
	$(INSTALL_BIN) ./files/udev $(1)/etc/init.d/udev
	$(INSTALL_BIN) ./files/uci-defaults/50-bluetooth-set-name $(1)/etc/uci-defaults/50-bluetooth-set-name
	$(INSTALL_BIN) ./files/hotplug.d/20-rndis $(1)/etc/hotplug.d/net/20-rndis
	$(INSTALL_BIN) ./files/hotplug.d/block/10-mount.sh $(1)/etc/hotplug.d/block/10-mount
	$(INSTALL_BIN) ./files/hotplug.d/block/20-swap.sh $(1)/etc/hotplug.d/block/20-swap
	$(INSTALL_BIN) ./files/hotplug.d/block/block.sh $(1)/lib/functions/block.sh
	$(INSTALL_BIN) ./files/usb-hotplug $(1)/root/usb-hotplug
	$(INSTALL_DATA) ./files/bluetooth.conf $(1)/etc/dbus-1/system.d/bluetooth.conf
	$(CP) -r $(PKG_BUILD_DIR)/ecr-app $(1)/www
endef

define Package/lede-ecr-app/postinst
#!bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/ecr enable
	/etc/init.d/wanStatus enable
fi
exit 0
endef

define Package/lede-ecr-app/prerm
#!/bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/ecr disable
	/etc/init.d/wanStatus disable
fi
exit 0
endef 

$(eval $(call BuildPackage,lede-ecr-app))
