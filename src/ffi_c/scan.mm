#import "wifi.h"
#import <CoreWLAN/CoreWLAN.h>
#import <Foundation/Foundation.h>
#include <stdlib.h>
#include <string.h>

extern "C" WifiScanResult cc_scan(void) {
    @autoreleasepool {
        CWInterface *iface =
            [CWWiFiClient sharedWiFiClient].interface;

        NSError *error = nil;
        NSSet<CWNetwork *> *nets =
            [iface scanForNetworksWithName:nil error:&error];

        if (error || !nets) {
            return (WifiScanResult){NULL, 0};
        }

        uint32_t count = (uint32_t)[nets count];
        WifiNetwork *arr =
            (WifiNetwork *)calloc(count, sizeof(WifiNetwork));

        uint32_t i = 0;
        for (CWNetwork *n in nets) {
            WifiNetwork *w = &arr[i++];

            if (n.ssid)  strncpy(w->ssid,  n.ssid.UTF8String,  32);
            if (n.bssid) strncpy(w->bssid, n.bssid.UTF8String, 17);

            w->rssi    = n.rssiValue;
            w->channel = n.wlanChannel.channelNumber;

            w->ht = [n.wlanChannel channelWidth] != kCWChannelWidth20MHz;
        }

        return (WifiScanResult){arr, count};
    }
}

extern "C" void cc_free_scan(WifiScanResult result) {
    free(result.items);
}
