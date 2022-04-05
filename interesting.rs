#![crate_name="interesting"]
#![crate_type="rlib"]

#[no_mangle]
#[inline(always)]
pub extern fn hello() {
    println!("Hello Porra!");
}
