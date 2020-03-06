// This is meant to be a universal DSDT patch template for anyone who wants to use it. All you need to do is change the contents of sections 1-3 with the proper information which is present within you own devices IOREG layout.
// All of the other entries are essentially cosmetic except for the "compatible" and "pci-aspm-default" portions of injected properties. Those two should be kept the way they are currently set, especially the pci-aspm-default property as it is the property which fixes these cards.

// The only things that may you should change have been underlined and look lik "-------". The also have lables as section 1-3, do not change any other options and when your configuration options have been properly entered,
// click file and then save as and choose ACPI Machine Language from the file format box then save the file in a location where you can find it. Copy the newly saved .aml file to clovers ACPI/patch folder and reboot.

DefinitionBlock("", "SSDT", 2, "ARPT ", "BCM4350", 0)
{
                                                                     // *** SECTION 1 *** \\
    External (_SB_.PCI0.RP01, UnknownObj)
    External (_SB_.PCI0.RP01.ARPT, UnknownObj)
    External (ARPT, UnknownObj)
    //                  -------------------------------
                                                                     // Replace "_SB.PCI0.RP01" with the name of the NGFF port that your WiFi/USB card has been installed in (Like RP0x or EXPx with x being a number 1-9)
                                                                     // Some possible configurations could be "(_SB_.PCI0.RP04)" or "(_SB.PCI0.EXP3)" 
                                                                     // <YOUR LAPTOP'S NGFF IOREG NAME> is replaced by some 4 letter combination thats is already in your systems IOREG configuration table assigned to the NGFF slot holding the Wireless card.
                                                      
                                                      // *** SECTION 2 *** \\                                                        
    Device (_SB.PCI0.RP01)
    {//              ------------------------------- 
                                                      // Replace "_SB.PCI0.RP01" here with the same name you replaced in the above line for External (_SB_.PCI0.<YOUR LAPTOP'S NGFF IOREG NAME> 
                                                      // Both lines need to have same hardware name or there will be an error when attempting to compile an AML from this template!
                                                      // So if <YOUR LAPTOP'S NGFF IOREG NAME> was changed to RP02 in the first section then you must change <YOUR LAPTOP'S NGFF IOREG NAME> in this portion to RP02 also!
                      // *** SECTION 3 *** \\      
        Device (ARPT)
        {//     ---- 
                      // The IOREG NAME assigned to you BCM4350 based hardware should be changed from its 4 letter name to ARPT.
                      // The name will vary depending on laptop manufacturers. Dell devices will be named something like "SB.PCI0.RP04.PXSX" (PCI0 is the PCIe bridge, RP04 is the NGFF port where you installed the WiFi card, and PXSX is the actual WiFi card).
                      // So if your system was SB.PCI0.RP04.PXSX as well then "Device (ARPT)" in this section would originally have been named "PXSX" and needs to be modified only by swapping PXSX with ARPT and thats all.
//                                       
            Name (_ADR, Zero)
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg2, Zero))
                {
                    Return (Buffer (One)
                    {
                        0x03                                           
                    })
                }                
                Return (Package ()
                {
//                    
                    "AAPL,slot-name",  // This is the name of the WiFi cards port where its been installed (The NGFF Port) as reported by the System Information App. 
                    Buffer ()          // This entry is purely cosmetic and serves no required purpose for its presence other than seeing information about it in the System Information App.
                    {
                        "WLAN"         // The name the NGFF slot will return in System Info.
                    },
//                    
                    "compatible",      // Designates a specific hardware chipset for another WiFi card which is compatible with the one installed and is able to the same kext to establish proper communication with the OS to funcion.
                    Buffer ()          // Although the card is supported OOB we use this entry to spoof another piece of stock hardware which is using a kext that is better for stability and thus should be kept in the final patch. 
                    {
                        "pci14e4,4331" // PCI ID of an AirPort card thats natively supported. The BCM450 card carries an ID which is also natively supported however it's with a card that uses a newer kext that isn't stable as the one we are spoofing.
                    },                 // The card can also be spoofed to use ID: pci14e4,4353 however with this ID some newer features such as unlock with Apple Watch functionality will not work for unknown reasons.
//                    
                    "device_type",     // Reports the hardware classification as an official Apple branded AirPort WiFi device instead of 3rd party WiFi card in System Information App. Not required for patch to work
                    Buffer ()
                    {
                        "AirPort"      // The AirPort designation makes the system believe the wireless card installed is an official Apple AirPort Extreme Wireless Network Card instead of a PC based one from another 
                    },
//                    
                    "model",           // Cosmetic injection property. Just reports whatever is written in the System Info app under the WiFi devices assigned section. Has no effect over functionality.
                    Buffer ()
                    {
                        "Dell DW1820a 802.11ac Wireless Card"
                    }, 
//                    
                    "name",            // Cosmetic as well, just shows the name of the card as being AirPort Extreme like it would show with a real Mac device thats using an official AirPort WiFi card.
                    Buffer ()
                    {
                        "AirPort Extreme"
                    },
//                    
                    "pci-aspm-default", // *** THIS OPTION IS WHAT WILL FIX ALL OF THE REPORTED ISSUES WITH THIS CHIPSET ON ALL DEVICES AND MAKE ALL VERSIONS OF THE BCM9450 CHIPSET FUNCTION PROPERLY ***
                    Buffer ()           // The issue is focused around the PCIe Active System Power Management function and the way in which functionality is designed differently between Mac devices and PC devices.
                    {
                        0x00           // 0x00 (0) Disables ASPM for PCIe devices in macOS and thus solves the issues that Broadcom BCM94350Zae based hardware designed for PC's has been riddled with while running within macOS enviornments.
                    }
                })
            }
        }
    }
}