// #[link(name = "xyz")]
#[link(name = "xyz", kind = "static")]
extern "C" {
    fn c_always_inlined() -> u32;
    fn c_never_inlined() -> u32;
}

// extern {
//     fn c_always_inlined() -> u32;
//     fn c_never_inlined() -> u32;
// }

fn main() {
//     println!("cargo:rustc-link-search=native=/insilications/apps/rustc-nightly-src/src/test/run-make-fulldeps/cross-lang-lto-pgo-smoketest/");
//     println!("cargo:rustc-link-lib=static=xyz");
    unsafe {
        println!("blub: {}", c_always_inlined() + c_never_inlined());
    }
}
