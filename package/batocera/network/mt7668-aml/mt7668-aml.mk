################################################################################
#
# mt7668-aml
#
################################################################################

MT7668-AML_VERSION = fd76e10404b220c552fc7951f5a359b56d599e3b
MT7668-AML_SITE = $(call github,khadas,android_hardware_wifi_mtk_drivers_mt7668,archive,$(MT7668-AML_VERSION.tar.gz))
MT7668-AML_LICENSE = GPL
MT7668-AML_LICENSE_FILES = LICENSE

MT7668-AML_MODULE_MAKE_OPTS = \
	CONFIG_MT7668-AML=m \
# batocera: setting KVER breaks top level parallelization
	# KVER=$(LINUX_VERSION_PROBED)
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

define MT7668-AML_MAKE_SUBDIR
        (cd $(@D); ln -s . MT7668-AML)
endef

MT7668-AML_PRE_CONFIGURE_HOOKS += MT7668-AML_MAKE_SUBDIR

$(eval $(kernel-module))
$(eval $(generic-package))
