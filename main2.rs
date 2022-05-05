// // #[derive(Copy, PartialEq, PartialOrd, Clone, Ord, Eq, Hash, Debug, Encodable, Decodable)]
// fn checked_division(dividend: i32, divisor: i32) -> Option<i32> {
//     if divisor == 0 {
//         // Failure is represented as the `None` variant
//         None
//     } else {
//         // Result is wrapped in a `Some` variant
//         Some(dividend / divisor)
//     }
// }
//
// // This function handles a division that may not succeed
// fn try_division(dividend: i32, divisor: i32) {
//     // `Option` values can be pattern matched, just like other enums
//     match checked_division(dividend, divisor) {
//         None => println!("{} / {} failed!", dividend, divisor),
//         Some(quotient) => {
//             println!("{} / {} = {}", dividend, divisor, quotient)
//         },
//     }
// }

// rustc -Cpanic=abort main2.rs -o main2

/// LLVMRustOptStage
#[derive(PartialEq, Debug)]
#[repr(C)]
pub enum OptStage {
    PreLinkNoLTO,
    PreLinkThinLTO,
    PreLinkFatLTO,
    ThinLTO,
    FatLTO,
}

#[derive(Clone, PartialEq, Debug)]
pub enum Lto {
    /// Don't do any LTO whatsoever.
    No,

    /// Do a full-crate-graph (inter-crate) LTO with ThinLTO.
    Thin,

    /// Do a local ThinLTO (intra-crate, over the CodeGen Units of the local crate only). This is
    /// only relevant if multiple CGUs are used.
    ThinLocal,

    /// Do a full-crate-graph (inter-crate) LTO with "fat" LTO.
    Fat,
}

#[derive(Copy, PartialEq, PartialOrd, Clone, Ord, Eq, Hash, Debug)]
pub enum CrateType {
    Executable,
    Dylib,
    Rlib,
    Staticlib,
    Cdylib,
    ProcMacro,
}

fn main() {
    let mut sess_lto: Lto = Lto::Fat;
    let cgcx_lto: Lto = Lto::Fat;

    // If the linker does LTO, we don't have to do it. Note that we
    // keep doing full LTO, if it is requested, as not to break the
    // assumption that the output will be a single module.

//     let linker_does_lto = opts.cg.linker_plugin_lto.enabled();
    let linker_does_lto = true;

    // When we're automatically doing ThinLTO for multi-codegen-unit
    // builds we don't actually want to LTO the allocator modules if
    // it shows up. This is due to various linker shenanigans that
    // we'll encounter later.

//     let is_allocator = module_kind == ModuleKind::Allocator;
    let is_allocator = true;

    // We ignore a request for full crate graph LTO if the crate type
    // is only an rlib, as there is no full crate graph to process,
    // that'll happen later.
    //
    // This use case currently comes up primarily for targets that
    // require LTO so the request for LTO is always unconditionally
    // passed down to the backend, but we don't actually want to do
    // anything about it yet until we've got a final product.

//     let is_rlib = sess_crate_types.len() == 1 && sess_crate_types[0] == CrateType::Rlib;
    let is_rlib = false;

    println!("Requested sess_lto: {:#?}", sess_lto);

    sess_lto = match sess_lto {
        Lto::ThinLocal if !linker_does_lto && !is_allocator => Lto::Thin,
        Lto::Thin if !linker_does_lto && !is_rlib => Lto::Thin,
        Lto::Fat if !is_rlib => Lto::Fat,
        _ => Lto::No,
    };
    println!("Final sess_lto: {:#?}", sess_lto);

    println!("\nRequested cgcx_lto: {:#?}", cgcx_lto);
    let opt_stage = match cgcx_lto {
        Lto::Fat => OptStage::PreLinkFatLTO,
        Lto::Thin | Lto::ThinLocal => OptStage::PreLinkThinLTO,
        _ if linker_does_lto => OptStage::PreLinkThinLTO,
        _ => OptStage::PreLinkNoLTO,
    };

    println!("Final opt_stage: {:#?}", opt_stage);

//     try_division(4, 2);
//     try_division(1, 0);
//
//     // Binding `None` to a variable needs to be type annotated
//     let _equivalent_none = None::<i32>;
//
//     let optional_float = Some(0f32);
//
//     // Unwrapping a `Some` variant will extract the value wrapped.
//     println!("{:?} unwraps to {:?}", optional_float, optional_float.unwrap());

}
