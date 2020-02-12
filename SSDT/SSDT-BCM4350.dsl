// The DSDT patch required to inject properties could look like this... 

// IOREG names for yours may be different and as such require that the proper location of your BCM4350 based WiFi card are properly identified!

// Somee systems will have the card located at PCI0.RP01.PXSX (RP01 could be RP02 or an other ending digit) and PXSX could also be labled as ARPT
// ARPT is the proper designation so you should also change PXSX to ARPT if need be! Most Dell systems use the RP0x lable

// Other systems may have the location of the card pointing to PCI0.EXP1.ARPT (with multiple variations of EXP possible as well)
// be sure to locate the proper address of your systems hardware and input the proper locations in this fle in order for this patch to work.

// THE MOST IMPORTANT INPUT IS THE OPTION: "pci-aspm-default" returning the "0x00" input! This is what will fix all issues that have been reported 
// across all versions of this particular wireless cards chipset no matter which version you happen to have from all know manufacturers! With this 
// option present the card will work regardless of which card it happens to be enabled with. 


DefinitionBlock("", "SSDT", 2, "ARPT ", "BCM4350", 0)
{
    External (_SB_.PCI0.RP03, UnknownObj)
    
    Device (_SB.PCI0.RP03) // RP03 IS JUST AN EXAMPLE! // CHANGE ACCORDING TO YOUR HARDWARES LABLE STRUCTURE!
    {
        name (_ADR, 0x001C0002) // ADDRESS SHOULD BE UPDATED TO REFLECT YOUR DEVICES ADDRESS FOR THE WIFI CARD!!
        Device (PXSX) // DW1820A card attached to this device (FixAirport fix required if such device is missing) SHOULD RENAME PXSX TO ARPT OR ENABLE CLOVER FIX FOR ARPT
        {
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
                    "AAPL,slot-name",      // Optional
                    Buffer ()
                    {
                        "WLAN"
                    }, 
                    "device_type",         // Optional
                    Buffer ()
                    {
                        "Airport Extreme"
                    }, 
                    "name",                // Optional
                    Buffer ()
                    {
                        "Airport"
                    }, 
                    "model",               // Optional
                    Buffer ()
                    {
                        "Dell DW1820A 802.11ac wireless"
                    }, 
                    "compatible",          // Mandatory
                    Buffer ()
                    {
                        "pci14e4,4331"     // Declares compatibility with BCM94331; "pci14e4:4353" for BCM43224 may also be used
                    }, 
                    "pci-aspm-default",    // THIS OPTION IS WHAT WILL FIX ALL OF THE REPORTED ISSUES WITH THIS CHIPSET ON ALL DEVICES AND MAKE ALL VERSIONS OF THE BCM9450 CHIPSET FUNCTION PROPERLY
                    Buffer (One)
                    {
                        0x00               // Disables ASPM for PCIe device
                    }
                })
            }
        }
    }
}    