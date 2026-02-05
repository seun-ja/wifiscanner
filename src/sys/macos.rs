use crate::{Result, Wifi, sys::WifiScanResult};

/// Returns a list of WiFi hotspots in your area - (OSX/MacOS) uses `airport`
pub(crate) fn scan() -> Result<Vec<Wifi>> {
    let v = unsafe {
        let result = cc_scan();
        if result.items.is_null() {
            return Ok(vec![]);
        }

        let slice = std::slice::from_raw_parts(result.items, result.len as usize);

        let networks: Vec<Wifi> = slice.iter().map(|n| n.into()).collect();

        cc_free_scan(result);
        networks
    };

    Ok(v)
}

unsafe extern "C" {
    pub(crate) fn cc_scan() -> WifiScanResult;
    pub(crate) fn cc_free_scan(result: WifiScanResult);
}
