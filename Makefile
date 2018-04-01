MAKEARGS := -C $(CURDIR)/buildroot 
MAKEARGS += O=$(CURDIR)/output
MAKEARGS += BR2_EXTERNAL=$(CURDIR)
DEFCONFIG_FILE=$(CURDIR)/defconfig
DEFCONFIG := BR2_DEFCONFIG=$(DEFCONFIG_FILE)
ALT_DEFCONFIG := BR2_DEFCONFIG=$(CURDIR)/defconfig

config_change_targets:=menuconfig nconfig xconfig gconfig oldconfig \
       	silentoldconfig randconfig allyesconfig allnoconfig randpackageconfig \
       	allyespackageconfig allnopackageconfig

special_target:=$(config_change_targets) Makefile defconfig savedefconfig %_defconfig

all	:= $(filter-out $(special_target),$(MAKECMDGOALS))

default:  
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) defconfig
	$(MAKE) $(MAKEARGS) $(DEFCONFIG)

.PHONY: $(special_target) $(all) 

defconfig:
	$(MAKE) $(MAKEARGS) $(ALT_DEFCONFIG) $@
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) savedefconfig

savedefconfig:
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) defconfig
	$(MAKE) $(MAKEARGS) $(ALT_DEFCONFIG) savedefconfig

%_defconfig:
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) $@
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) savedefconfig
	$(call UPDATE_DEFCONFIG)

$(config_change_targets): $(DEFCONFIG_FILE)
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) defconfig $@
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) savedefconfig

_all:
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) $(all)

$(all): _all
	@:

%/: _all
	@:

Makefile:;

$(DEFCONFIG_FILE):
	$(call UPDATE_DEFCONFIG)

define UPDATE_DEFCONFIG
	echo 'BR2_DL_DIR="$$(BR2_EXTERNAL_STAT_PATH)/dl"' >> $(DEFCONFIG_FILE)
	echo 'BR2_ROOTFS_OVERLAY="$$(BR2_EXTERNAL_STAT_PATH)/overlay"' >> $(DEFCONFIG_FILE)
	echo 'BR2_PACKAGE_OVERRIDE_FILE="$$(BR2_EXTERNAL_STAT_PATH)/local.mk"' >> $(DEFCONFIG_FILE)
	echo 'BR2_GLOBAL_PATCH_DIR="$$(BR2_EXTERNAL_STAT_PATH)/patch"' >> $(DEFCONFIG_FILE)
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) defconfig
	$(MAKE) $(MAKEARGS) $(DEFCONFIG) savedefconfig
endef
