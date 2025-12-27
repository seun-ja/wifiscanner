#import <CoreWLAN/CoreWLAN.h>
#import <Foundation/Foundation.h>
#include <iostream>
#include <iomanip>

int main() {
    @autoreleasepool {
        CWInterface *iface =
            [CWWiFiClient sharedWiFiClient].interface;

        NSError *error = nil;
        NSSet<CWNetwork *> *nets =
            [iface scanForNetworksWithName:nil error:&error];

        if (error || !nets) {
            return 1;
        }

        std::cout
            << std::left
            << std::setw(32) << "SSID"
            << std::setw(20) << "BSSID"
            << std::setw(6)  << "RSSI"
            << std::setw(8)  << "CHANNEL"
            << std::setw(4)  << "HT"
            << "SECURITY"
            << "\n";

        for (CWNetwork *n in nets) {
            std::string ssid =
                n.ssid ? n.ssid.UTF8String : "";

            std::string bssid =
                n.bssid ? n.bssid.UTF8String : "";

            int rssi = n.rssiValue;
            int channel = n.wlanChannel.channelNumber;

            const char *ht = "";
            const char *security = "UNKNOWN";

            std::cout
                << std::left
                << std::setw(32) << ssid
                << std::setw(20) << bssid
                << std::setw(6)  << rssi
                << std::setw(8)  << channel
                << std::setw(4)  << ht
                << security
                << "\n";
        }
    }
}
