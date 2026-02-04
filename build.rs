use std::env;

fn main() {
    let target = env::var("TARGET").unwrap();

    // Only build Obj-C++ bridge on macOS
    // Only run on macOS
    if !target.contains("apple-darwin") {
        return;
    }

    // cc::Build::new()
    //     .file("src/ffi_c/scan.mm")
    //     .flag("-x")
    //     .flag("objective-c++")
    //     .flag("-std=c++17")
    //     .flag("-fobjc-arc")
    //     .compile("cc_scan");

    cc::Build::new()
        .file("src/ffi_c/scan.mm")
        .cpp(true) // important for Objective-C++
        .flag_if_supported("-std=c++17") // optional
        .compile("wifiscanner");

    println!("cargo:rustc-link-lib=c++");

    println!("cargo:rustc-link-lib=framework=Foundation");
    println!("cargo:rustc-link-lib=framework=CoreWLAN");
}
