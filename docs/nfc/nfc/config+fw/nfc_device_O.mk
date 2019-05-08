#
# File included from device/<manufacture>/<>/<device>.mk
# Packages to include into the build
PRODUCT_PACKAGES += \
    NfcNci \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.pn54x.default \
	com.nxp.nfc \
	vendor.nxp.nxpnfc@1.0-service \
	vendor.nxp.nxpnfc@1.0 \
	android.hardware.nfc@1.0-impl \
	vendor.nxp.nxpnfc@1.0-impl \
	android.hardware.nfc@1.0
#	DTA:
#	NxpDTA	\
#	libdta.so	\
#	libdta_jni.so	\
#	libmwif.so	\
#	libosal.so
	
	
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml	\
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:system/etc/permissions/android.hardware.nfc.hcef.xml \
#	external/libnfc-nci/halimpl/pn54x/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
#	external/libnfc-nci/halimpl/pn54x/libnfc-nxp-PN548AD_example.conf:system/etc/libnfc-nxp.conf
#	conf and SO,for mail nxp FAE
#	external/libnfc-nci/libpn548ad_fw.so:system/vendor/firmware/libpn548ad_fw.so	\
	

