---
# Broadcom BCM4350 Full Support (macOS 10.10 - 10.15)
---

### Supports all BCM4350 cards with Yosemite - Catalina

Complete solution for for BCM4350 based wireless cards in MacOS. SOLVES ALL ISSUES ACROSS ALL CARDS

All credit goes to: 

Herve (https://osxlatitude.com/forums/topic/11322-broadcom-bcm4350-cards-under-high-sierramojavecatalina/?tab=comments#comment-96996) 

and the people who spent months putting this together on OSXlattitude via his thread dedicated to the topic.


You may use the config.plist or the DSDT patch. I would go with the plist method as its easier. The actual fix that will enable the proper functionality of this card no matter which version or manufacturer you're using is the addition of the device property : "pci-aspm-default" with a return of "0" as a "Number" based property under Devices/Properties/PciRootxxx 

PciRootxxx refers to the proper address of the card in your system which youll need to find as it may not be the same as whats in these files!!! Use your IOREG layout to determine the proper location.

The same applies for the address thats used in the SSDT file! Your hardware may be different and if it is the proper settings need to be changed in the DSDT patch file for the patch to work.
