FILESEXTRAPATHS:prepend:stm32mpcommon := "${THISDIR}/${PN}:"

# Add calibration file
SRC_URI:append:stm32mpcommon = " git://github.com/murata-wireless/cyw-fmac-nvram.git;protocol=https;nobranch=1;name=nvram;destsuffix=nvram-murata "
SRCREV_nvram = "45fe43ad51ad47a0c57ad307db3e87da766bf61e"
SRC_URI:append:stm32mpcommon = " git://github.com/murata-wireless/cyw-fmac-fw.git;protocol=https;nobranch=1;name=murata;destsuffix=murata "
SRCREV_murata = "52174a18134c7ef4a674ecd9fb68fc6e2bced969"
SRCREV_FORMAT = "linux-firmware-murata"

do_install:append:stm32mpcommon() {
   # Install calibration file
   install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt
   # Install calibration file (stm32mp15)
   install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157c-dk2.txt
   install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157f-dk2.txt
   # Install calibration file (stm32mp13)
   install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp135f-dk.txt

   # Take newest murata firmware
   install -m 0644 ${WORKDIR}/murata/cyfmac43430-sdio.bin ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.bin
   install -m 0644 ${WORKDIR}/murata/cyfmac43430-sdio.1DX.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.clm_blob

   # Add symlinks for newest kernel compatibility
   cd ${D}${nonarch_base_libdir}/firmware/brcm/
   ln -sf brcmfmac43430-sdio.bin brcmfmac43430-sdio.st,stm32mp157c-dk2.bin
   ln -sf brcmfmac43430-sdio.bin brcmfmac43430-sdio.st,stm32mp157f-dk2.bin
   ln -sf brcmfmac43430-sdio.bin brcmfmac43430-sdio.st,stm32mp135f-dk.bin
}


FILES:${PN}-bcm43430:append:stm32mpcommon = " \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157c-dk2.* \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157f-dk2.* \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp135f-dk.* \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.clm_blob \
  ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.bin \
"

RDEPENDS:${PN}-bcm43430:remove:stm32mpcommon = " ${PN}-cypress-license "
