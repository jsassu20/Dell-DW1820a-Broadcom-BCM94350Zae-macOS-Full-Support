---
# Broadcom BCM94350Zae Support (macOS 10.10 - 10.15)
---
---
### Supports all variants of the Broadcom BCM94350Zae (BCM4350) chipset currently available as NGFF A/E based Wireless AC and Bluetooth 4.1 hardware!
---

### Background:

There are a small number of AC based cards which work in Hackintosh devices (especially laptops) which has driven the price of the ones that do work up substantially. The BCM94350Zae (BCM4350 in Apple devices) chipset is a known variant of WiFi based hardware which macOS supports OOB as it happens to be present in the 2015 Macbook revival from the white plastic 12" lineup that was brought back for only 2 generations before being killed off again. The problem that hackintosh users were dealin with is that all PC based versions of this chipset have been a nightmare to get their systems properly working across various Hackintosh builds in any sort of consistent manner like you can with other PC cards such as the Dw1803 or DW1560 based hardware has been able to provide. The consensus was that you would be likely to run into any number of issues if you chose to purchase any of the handful of known variants of the BCM94350Zae hardware thats currently on the market. Those being the Dell Dw1820a (which is the most common and happens to have 5 seperate variants of their version of this hardware), Lenovo's 00JT493, and Foxcon's T77H649. Some people reported perfect functionality and others complete chaos with a wide range of issues reported from many different individuals across all known versions making the card a complete shot in the dark if you wanted to purchase it for your setup. I spent months myself trying to put together a somewhat reasonable configuration and eventually gave up due to a complete instability in my configuration no matter what I tried. Well the good folks over at OSXdaily continued with what I threw in the towel on and after months and months of collaboration through user Herve's thread dedicated to the topic they have managed to solve the problem that was causing all variants of this hardware to be so unstable. The issue can be solved by adding the device property setting "pci-aspm-default" with a Number based definition of "0" in clovers Devices/Properties section under the PciRoot address that you system assigns to the actual card (which is not universal and needs to be known in order for you to create the property patch with clover configurator in the config.plist or with a DSDT patch which is how you can resolve the problem!


### Instructions: 

You may use the config.plist or the DSDT patch. I would go with the plist method as its easier. The actual fix that will enable the proper functionality of this card no matter which version or manufacturer you're using is the addition of the device property : "pci-aspm-default" with a return of "0" as a "Number" based property under Devices/Properties/PciRootxxx 

PciRootxxx refers to the proper address of the card in your system which youll need to find as it may not be the same as whats in these files!!! Use your IOREG layout to determine the proper location.

The same applies for the address thats used in the SSDT file! Your hardware may be different and if it is the proper settings need to be changed in the DSDT patch file for the patch to work.

---
### All Credit Goes To: 

Herve - (https://osxlatitude.com/forums/topic/11322-broadcom-bcm4350-cards-under-high-sierramojavecatalina/?tab=comments#comment-96996)
---
