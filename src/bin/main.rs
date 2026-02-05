fn main() {
    let networks = wifiscanner::scan().expect("Cannot scan network");
    for network in networks {
        println!(
            "Mac: {} SSID: {:15} Channel: {:10} Signal Level: {:4} Security: {}",
            network.mac, network.ssid, network.channel, network.signal_level, network.security
        );
    }
}
