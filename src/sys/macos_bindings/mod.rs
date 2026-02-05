use crate::Wifi;

#[repr(C)]
pub struct WifiNetwork {
    pub bssid: [i8; 18],
    pub ssid: [i8; 33],
    pub channel: i32,
    pub rssi: i32,
    pub ht: u8,
}

impl From<&WifiNetwork> for Wifi {
    fn from(value: &WifiNetwork) -> Self {
        let mut bssid = String::from_utf8_lossy(unsafe {
            std::slice::from_raw_parts(value.bssid.as_ptr() as *const u8, 18)
        })
        .into_owned();

        bssid = bssid.trim_matches('\0').to_string();

        if bssid.is_empty() {
            bssid = "Redacted".to_string()
        }

        let mut ssid = String::from_utf8_lossy(unsafe {
            std::slice::from_raw_parts(value.ssid.as_ptr() as *const u8, 18)
        })
        .into_owned();

        ssid = ssid.trim_matches('\0').to_string();

        if ssid.is_empty() {
            ssid = "Redacted".to_string();
        }

        Self {
            mac: bssid,
            ssid,
            channel: value.channel.to_string(),
            signal_level: value.rssi.to_string(),
            security: "Redacted".to_string(),
        }
    }
}

#[repr(C)]
pub struct WifiScanResult {
    pub items: *mut WifiNetwork,
    pub len: u32,
}
