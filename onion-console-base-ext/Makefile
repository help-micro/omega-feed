include $(TOPDIR)/rules.mk
PKG_NAME:=onion-console-base-ext
PKG_VERSION:=0.1.6
PKG_RELEASE:=1


PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=HEAD # dev for dev branch, HEAD for master
PKG_SOURCE_URL:=https://github.com/OnionIoT/Onion-Console.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/onion-console-base-ext
	SECTION:=ECR
	CATEGORY:=ECR
	SUBMENU:=Console
	TITLE:=Extended web-based virtual desktop for the Omega
	DEPENDS:=+rpcd +oupgrade
endef

define Package/onion-console-base-ext/description
Web-based virtual desktop for the Omega. Base package with bluetooth and 3G extension
endef

define Package/onion-console-base-ext/install
	# install the acl permissions file
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_BIN) ./files/acl.d/onion-console.json $(1)/usr/share/rpcd/acl.d/onion-console.json
	# install scripts
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/bin/factory-reset.sh $(1)/usr/sbin/factory-reset
	$(INSTALL_BIN) ./files/bin/power-down.sh $(1)/usr/sbin/power-down
	$(INSTALL_BIN) ./files/bin/change-password.sh $(1)/usr/sbin/change-password
	$(INSTALL_BIN) ./files/bin/disk-space.sh $(1)/usr/sbin/disk-space
	$(INSTALL_BIN) ./files/bin/oupgrade.sh $(1)/usr/bin/oupgrade
	# install the rpcd script
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./files/rpcd/onion-console.sh $(1)/usr/libexec/rpcd/onion-console
	$(INSTALL_BIN) ./files/rpcd/onion-bt.sh $(1)/usr/libexec/rpcd/onion-bt
	# copy the web site files, starting with the lib and element folders
	$(INSTALL_DIR) $(1)/www/console
	# Create a lib directory
	 $(INSTALL_DIR) $(1)/www/console/lib
	# Create a elements directory
	$(INSTALL_DIR) $(1)/www/console/elements
	# Create the apps directory
	$(INSTALL_DIR) $(1)/www/console/apps
	# Create the scripts directory
	$(INSTALL_DIR) $(1)/www/console/scripts
	# Create the directory for the onion-launcher
	$(INSTALL_DIR) $(1)/www/console/apps/onion-launcher
	# Create the directort for onion-login
	$(INSTALL_DIR) $(1)/www/console/apps/onion-login
	# Create the directory for the onion-settings
	$(INSTALL_DIR) $(1)/www/console/apps/onion-settings
	
	# Create the directory for bluez python
	$(INSTALL_DIR) $(1)/usr/bin/pybluez
	$(INSTALL_BIN) ./files/pybluez/get-adapter-state $(1)/usr/bin/pybluez/get-adapter-state
	$(INSTALL_BIN) ./files/pybluez/set-adapter-state $(1)/usr/bin/pybluez/set-adapter-state
	$(INSTALL_BIN) ./files/pybluez/scan-devices $(1)/usr/bin/pybluez/scan-devices
	$(INSTALL_BIN) ./files/pybluez/get-devices $(1)/usr/bin/pybluez/get-devices
	$(INSTALL_BIN) ./files/pybluez/connect-to-network $(1)/usr/bin/pybluez/connect-to-network
	$(INSTALL_BIN) ./files/pybluez/pair $(1)/usr/bin/pybluez/pair
	$(INSTALL_BIN) ./files/pybluez/remove-device $(1)/usr/bin/pybluez/remove-device
	$(INSTALL_BIN) ./files/pybluez/bluezutils.py $(1)/usr/bin/pybluez/bluezutils.py
	
	$(INSTALL_BIN) ./files/www/scripts/ping.py $(1)/www/console/scripts/ping.py

	# Create the services directory
	$(INSTALL_DIR) $(1)/www/console/services
	# Create the fonts directory
	$(INSTALL_DIR) $(1)/www/console/fonts
	# Create the images directory
	$(INSTALL_DIR) $(1)/www/console/images

	# copy the lib directory
	cp -r ./files/www/lib/* $(1)/www/console/lib/.
	# copy the elements directory
	cp -r ./files/www/elements/* $(1)/www/console/elements/.
	# copy the fonts directory
	cp -r ./files/www/fonts/* $(1)/www/console/fonts/.
	# copy the images directory
	cp -r ./files/www/images/* $(1)/www/console/images/.
	# copy the services directory
	cp -r ./files/www/services/* $(1)/www/console/services/.
	# copy other random files
	cp ./files/www/.bowerrc $(1)/www/console/.bowerrc
	cp ./files/www/bower.json $(1)/www/console/bower.json
	cp ./files/www/index.html $(1)/www/console/index.html
	cp ./files/www/info.json $(1)/www/console/info.json
	# copy the apps into the directory
	# copy the launcher app
	cp -r ./files/www/apps/onion-launcher/* $(1)/www/console/apps/onion-launcher/.
	cp -r ./files/www/apps/onion-settings/* $(1)/www/console/apps/onion-settings/.
	cp -r ./files/www/apps/onion-login/* $(1)/www/console/apps/onion-login/.

endef

$(eval $(call BuildPackage,onion-console-base-ext))