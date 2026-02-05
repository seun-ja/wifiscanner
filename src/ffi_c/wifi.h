#pragma once
#include <stdint.h>

typedef struct {
    char ssid[33];
    char bssid[18];
    int32_t rssi;
    int32_t channel;
    uint8_t ht;
} WifiNetwork;

typedef struct {
    WifiNetwork *items;
    uint32_t len;
} WifiScanResult;

extern "C" WifiScanResult cc_scan(void);
extern "C" void cc_free_scan(WifiScanResult result);
