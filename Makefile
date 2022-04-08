# unexport LLVM_PROFILE_FILE
# export LLVM_PROFILE_FILE="/var/tmp/pgo/code-%p-%m.profraw"

# PASS_MANAGER_RUST=-Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
# PASS_MANAGER_RUST=-Clink-arg=-Wl,--lto-legacy-pass-manager -Clink-arg=-flegacy-pass-manager -Znew-llvm-pass-manager=no -Clink-args='-mllvm -enable-new-pm=0'
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=no -Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-fno-legacy-pass-manager -Clink-arg=-Wl,--mllvm=-enable-npm-pgo-inline-deferral
# -Cforce-unwind-tables=on
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral
RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-update=atomic
# RUST_PGO_GEN=-Zdebug-info-for-profiling=yes -Clink-arg=-g -Clink-arg=-Wl,--no-rosegment -Clink-arg=-fprofile-update=atomic
# RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-update=atomic
COMMON_FLAGS_GEN=$(RUST_PGO_GEN) $(PASS_MANAGER_RUST) -Clink-arg=-Wl,--mllvm=-relocation-model=static -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=4 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Cllvm-args=-inlinehint-threshold=29000 -Cllvm-args=-inlinedefault-threshold=29000 -Cllvm-args=-inlinecold-threshold=29000 -Cllvm-args=-inline-cold-callsite-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cllvm-args=-inlinehint-threshold=29000 -Cllvm-args=-inlinedefault-threshold=29000 -Cllvm-args=-inlinecold-threshold=29000 -Cllvm-args=-inline-cold-callsite-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cinline-threshold=29000 -Zprint-llvm-passes=yes -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions -Cllvm-args=-import-instr-evolution-factor=2 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=6 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-Wl,--mllvm=-whole-program-visibility -Cllvm-args=-whole-program-visibility -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1 -Zthinlto=yes -Cforce-unwind-tables=on -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Zrelro-level=full -Zverify-llvm-ir=yes -Clink-arg=--verbose -Cllvm-args=--x86-use-vzeroupper=0 -Clink-self-contained=off -Coverflow-checks=off -Cstrip=none -Cdebug-assertions=yes -Cdebuginfo=2 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=no -Ztune-cpu=native -Copt-level=3 -Cembed-bitcode=yes -Ctarget-feature=+crt-static -Ctarget-feature=+prefer-256-bit -Ctarget-feature=-vzeroupper -Cforce-frame-pointers=off -Cpanic=abort -Clinker=clang -Clink-arg=-Wno-unused-command-line-argument -Clink-arg=-Wall -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O3 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Clink-arg=-fuse-ld=lld -Clink-arg=-Wl,--as-needed -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-mllvm,-x86-use-vzeroupper=0 -Clink-arg=-Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Clink-arg=-Wno-error -Clink-arg=-Wl,--mllvm=-mattr=+prefer-256-bit -Clink-arg=-mprefer-vector-width=256 -Cllvm-args=-align-all-functions=5 -Clink-arg=-Wl,--mllvm=-align-all-functions=5 -Clink-arg=-falign-functions=32 -Clink-arg=-fno-semantic-interposition -Clink-arg=-Wl,-Bsymbolic-functions -Clink-arg=-fno-stack-protector -Clink-arg=-Wl,--mllvm=-enable-no-trapping-fp-math -Clink-arg=-fno-trapping-math -Clink-arg=-fno-math-errno -Clink-arg=-ftree-slp-vectorize -Clink-arg=-ftree-vectorize -Clink-arg=-feliminate-unused-debug-types -Clink-arg=-fno-plt -Clink-arg=-Wno-error -Clink-arg=-Wp,-D_REENTRANT -Clink-arg=-fvisibility-inlines-hidden -Clink-arg=-Wl,--mllvm=-frame-pointer=none -Clink-arg=-fomit-frame-pointer -Clink-arg=-static-libstdc++ -Clink-arg=-static-libgcc -Clink-arg=-pthread -Clink-arg=-gdwarf-4 -Cllvm-args=--dwarf-version=4 -Clink-arg=-Wl,--build-id=sha1 -Clink-arg=-fasynchronous-unwind-tables -Clink-arg=-funwind-tables -Clink-arg=-Wl,--emit-relocs -Clink-arg=-fno-PIC -Clink-arg=-fno-PIE -Clink-arg=-fno-pic -Clink-arg=-fno-pie -Clink-arg=-Wl,--no-pie -Zllvm-plugins=/usr/lib64/LLVMPolly.so -Cllvm-args=--polly -Cllvm-args=--polly-vectorizer=stripmine

# -Zllvm-plugins=/usr/lib64/LLVMPolly.so
# -mllvm -polly -mllvm -polly-vectorizer=stripmine

# -Wl,--emit-relocs
# --instrumentation-file-append-pid
# --relocs
# llvm-bolt ./rsmain --jump-tables=split --instrument --lite=0 --thread-count=10 --update-debug-sections --instrumentation-file=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/instr.fdata --instrumentation-sleep-time=1000 --instrumentation-wait-forks --instrumentation-file-append-pid --instrumentation-no-counters-clear -o=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain-instr
# llvm-bolt ./rsmain --instrument --lite=0 --thread-count=10 --update-debug-sections --instrumentation-file=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/instr.fdata --instrumentation-sleep-time=1 --instrumentation-wait-forks --instrumentation-file-append-pid --instrumentation-no-counters-clear -o=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain-instr
# llvm-bolt ./rsmain --instrument --lite=0 --thread-count=10 --update-debug-sections --instrumentation-file=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/instr.fdata --instrumentation-sleep-time=1000 --instrumentation-wait-forks --instrumentation-file-append-pid --instrumentation-no-counters-clear --relocs --lite=0 --reorder-blocks=cache+ --reorder-functions=hfsort+ --split-functions=2 --split-all-cold --split-eh --indirect-call-promotion=all --icp-eliminate-loads --plt=all --inline-all --inline-ap --inline-max-iters=6 --inline-limit=35000 --inline-memcpy --peepholes=all --align-macro-fusion=all --frame-opt=all --simplify-conditional-tail-calls --jump-tables=split --dyno-stats --print-profile-stats --bolt-info -o=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain-instr

# merge-fdata *.fdata > combined.fdata

# --fix-block-counts --fix-func-counts
# --dyno-stats-all --dyno-stats --print-dyno-stats-only
# --print-profile-stats
# --verify-cfg
# --indirect-call-promotion=all
# --icp-eliminate-loads
# --frame-opt=all
# --align-macro-fusion=all
# --peepholes=all
# --jump-tables=basic --jump-tables=split --jump-tables=aggressive
# --inline-limit=0
# --inline-max-iters=6
# --inline-memcpy
# --hugify
# --simplify-conditional-tail-calls
# --bolt-info
# -strict=0 -skip-funcs=_dl_runtime_profile.*
# --dyno-stats-all
# --icf
# --keep-aranges
# --use-gnu-stack

# llvm-bolt ./rsmain -o=./rsmain.bolt --data=./combined.fdata --relocs --lite=0 --reorder-blocks=cache+ --reorder-functions=hfsort+ --split-functions=2 --split-all-cold --split-eh --indirect-call-promotion=all --icp-eliminate-loads --plt=all --inline-all --inline-ap --inline-max-iters=6 --inline-limit=0 --inline-memcpy --peepholes=all --align-macro-fusion=all --frame-opt=all --simplify-conditional-tail-calls --jump-tables=split --dyno-stats --print-profile-stats --bolt-info

# llvm-bolt ./rg -o=./rg.bolt --data=./combined.fdata --relocs --lite=0 --reorder-blocks=cache+ --reorder-functions=hfsort+ --reorder-functions-use-hot-size --reorder-data-algo=count --cg-use-split-hot-size --split-functions=3 --split-all-cold --split-eh --indirect-call-promotion=all --top-called-limit=300 --icf --plt=all --hugify --runtime-hugify-lib=libbolt_rt_hugify.a --hot-data --align-functions=32 --icp-eliminate-loads --icp-top-callsites=0 --indirect-call-promotion-calls-topn=0 --indirect-call-promotion-jump-tables-topn=0 --indirect-call-promotion-topn=0 --inline-all --inline-ap --inline-max-iters=10 --inline-limit=0 --peepholes=all --align-macro-fusion=all --frame-opt=all --simplify-conditional-tail-calls --jump-tables=split --dyno-stats --print-profile-stats --bolt-info

RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/rustmerged.profdata -Clink-arg=-fprofile-use=/var/tmp/pgo/rustmerged.profdata -Clink-arg=-fprofile-update=atomic
# RUST_PGO_USE=-Zprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rustmerged.profdata -Clink-arg=-g -Clink-arg=-Wl,--no-rosegment -Clink-arg=-fprofile-update=atomic -Clink-arg=-fprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rustmerged.profdata
# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/rustmerged.profdata -Clink-arg=-fprofile-update=atomic
#
COMMON_FLAGS_USE=$(RUST_PGO_USE) $(PASS_MANAGER_RUST) -Clink-arg=-Wl,--mllvm=-relocation-model=static -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=4 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Cllvm-args=-inlinehint-threshold=29000 -Cllvm-args=-inlinedefault-threshold=29000 -Cllvm-args=-inlinecold-threshold=29000 -Cllvm-args=-inline-cold-callsite-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cllvm-args=-inlinehint-threshold=29000 -Cllvm-args=-inlinedefault-threshold=29000 -Cllvm-args=-inlinecold-threshold=29000 -Cllvm-args=-inline-cold-callsite-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=29000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-threshold=29000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=29000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=29000 -Cllvm-args=-inline-threshold=29000 -Cinline-threshold=29000 -Zprint-llvm-passes=yes -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions -Cllvm-args=-import-instr-evolution-factor=2 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=6 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-Wl,--mllvm=-whole-program-visibility -Cllvm-args=-whole-program-visibility -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1 -Zthinlto=yes -Cforce-unwind-tables=on -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Zrelro-level=full -Zverify-llvm-ir=yes -Clink-arg=--verbose -Cllvm-args=--x86-use-vzeroupper=0 -Clink-self-contained=off -Coverflow-checks=off -Cstrip=none -Cdebug-assertions=yes -Cdebuginfo=2 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=no -Ztune-cpu=native -Copt-level=3 -Cembed-bitcode=yes -Ctarget-feature=+crt-static -Ctarget-feature=+prefer-256-bit -Ctarget-feature=-vzeroupper -Cforce-frame-pointers=off -Cpanic=abort -Clinker=clang -Clink-arg=-Wno-unused-command-line-argument -Clink-arg=-Wall -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O3 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Clink-arg=-fuse-ld=lld -Clink-arg=-Wl,--as-needed -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-mllvm,-x86-use-vzeroupper=0 -Clink-arg=-Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Clink-arg=-Wno-error -Clink-arg=-Wl,--mllvm=-mattr=+prefer-256-bit -Clink-arg=-mprefer-vector-width=256 -Cllvm-args=-align-all-functions=5 -Clink-arg=-Wl,--mllvm=-align-all-functions=5 -Clink-arg=-falign-functions=32 -Clink-arg=-fno-semantic-interposition -Clink-arg=-Wl,-Bsymbolic-functions -Clink-arg=-fno-stack-protector -Clink-arg=-Wl,--mllvm=-enable-no-trapping-fp-math -Clink-arg=-fno-trapping-math -Clink-arg=-fno-math-errno -Clink-arg=-ftree-slp-vectorize -Clink-arg=-ftree-vectorize -Clink-arg=-feliminate-unused-debug-types -Clink-arg=-fno-plt -Clink-arg=-Wno-error -Clink-arg=-Wp,-D_REENTRANT -Clink-arg=-fvisibility-inlines-hidden -Clink-arg=-Wl,--mllvm=-frame-pointer=none -Clink-arg=-fomit-frame-pointer -Clink-arg=-static-libstdc++ -Clink-arg=-static-libgcc -Clink-arg=-pthread -Clink-arg=-gdwarf-4 -Cllvm-args=--dwarf-version=4 -Clink-arg=-Wl,--build-id=sha1 -Clink-arg=-fasynchronous-unwind-tables -Clink-arg=-funwind-tables -Clink-arg=-Wl,--emit-relocs -Clink-arg=-fsave-optimization-record=yaml -Clink-arg=-fdiagnostics-show-hotness -Clink-arg=-foptimization-record-passes=.* -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.* -Cremark=all -Clink-arg=-fno-PIC -Clink-arg=-fno-PIE -Clink-arg=-fno-pic -Clink-arg=-fno-pie -Clink-arg=-Wl,--no-pie

# -Clink-arg=-fPIC
# -Clink-arg=-Wl,--no-pie
# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments -Clink-arg=-Wl,--plugin-opt=debug-pass-manager
# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
#-Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments

# -Clink-arg=-Wl,--plugin-opt=debug-pass-manager
#"-Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)"
# "-Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)"
# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
# -Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)

# PASS_MANAGER_CFLAGS=-enable-new-pm=1 -fno-legacy-pass-manager -Wl,-mllvm,-enable-new-pm=1
# PASS_MANAGER_CFLAGS=-flegacy-pass-manager
PASS_MANAGER_CFLAGS=-fno-legacy-pass-manager -Wl,--mllvm=-enable-npm-pgo-inline-deferral
CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo -fprofile-update=atomic
# CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo
# CFLAGS_PGO_GEN=-Wl,--no-rosegment -fprofile-update=atomic
CFLAGS_GEN=$(CFLAGS_PGO_GEN) $(PASS_MANAGER_CFLAGS) -fembed-bitcode -mllvm -import-instr-limit=33000 -mllvm -import-all-index -mllvm -import-full-type-definitions -mllvm -import-instr-evolution-factor=6 -mllvm -inline-cost-full -mllvm -inlinehint-threshold=29000 -mllvm -inlinedefault-threshold=29000 -mllvm -inlinecold-threshold=29000 -mllvm -inline-cold-callsite-threshold=29000 -mllvm -inline-threshold=29000 -Wl,--mllvm=-import-instr-limit=33000 -Wl,--mllvm=-import-all-index -Wl,--mllvm=-import-full-type-definitions -Wl,--mllvm=-import-instr-evolution-factor=6 -Wl,--mllvm=-inline-cost-full -Wl,--plugin-opt=-inlinehint-threshold=29000 -Wl,--plugin-opt=-inlinedefault-threshold=29000 -Wl,--plugin-opt=-inlinecold-threshold=29000 -Wl,--plugin-opt=-inline-cold-callsite-threshold=29000 -Wl,--plugin-opt=-inline-threshold=29000 -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables -Wno-unused-command-line-argument -fno-legacy-pass-manager -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -mllvm -x86-use-vzeroupper=0 -Wl,--lto-O3 -Wl,-O3 -O3 -mno-vzeroupper -march=native -mtune=native -fuse-ld=lld -Wl,--as-needed -Wl,--enable-new-dtags -Wl,-plugin-opt=O3 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -mllvm -align-all-functions=5 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -funwind-tables -pipe -gdwarf-4 -Wl,--mllvm=-relocation-model=static -Wl,--emit-relocs -Wl,--mllvm=-align-all-functions=5 --verbose -DNDEBUG -O3 -falign-functions=32 -Wl,--mllvm=-relax-elf-relocations -fasynchronous-unwind-tables -fno-PIC -fno-PIE -fno-pic -fno-pie -Wl,--no-pie -fexceptions -mllvm -polly -mllvm -polly-vectorizer=stripmine

CFLAGS_PGO_USE=-fprofile-use=/var/tmp/pgo/rustmerged.profdata -fprofile-update=atomic
# CFLAGS_PGO_USE=-fprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rustmerged.profdata -Wl,--no-rosegment -fprofile-update=atomic
CFLAGS_USE=$(CFLAGS_PGO_USE) $(PASS_MANAGER_CFLAGS) -fembed-bitcode -mllvm -import-instr-limit=33000 -mllvm -import-all-index -mllvm -import-full-type-definitions -mllvm -import-instr-evolution-factor=6 -mllvm -inline-cost-full -mllvm -inlinehint-threshold=29000 -mllvm -inlinedefault-threshold=29000 -mllvm -inlinecold-threshold=29000 -mllvm -inline-cold-callsite-threshold=29000 -mllvm -inline-threshold=29000 -Wl,--mllvm=-import-instr-limit=33000 -Wl,--mllvm=-import-all-index -Wl,--mllvm=-import-full-type-definitions -Wl,--mllvm=-import-instr-evolution-factor=6 -Wl,--mllvm=-inline-cost-full -Wl,--plugin-opt=-inlinehint-threshold=29000 -Wl,--plugin-opt=-inlinedefault-threshold=29000 -Wl,--plugin-opt=-inlinecold-threshold=29000 -Wl,--plugin-opt=-inline-cold-callsite-threshold=29000 -Wl,--plugin-opt=-inline-threshold=29000 -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables -Wno-unused-command-line-argument -fno-legacy-pass-manager -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -mllvm -x86-use-vzeroupper=0 -Wl,--lto-O3 -Wl,-O3 -O3 -mno-vzeroupper -march=native -mtune=native -fuse-ld=lld -Wl,--as-needed -Wl,--enable-new-dtags -Wl,-plugin-opt=O3 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -mllvm -align-all-functions=5 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -funwind-tables -pipe -gdwarf-4 -Wl,--mllvm=-relocation-model=static -Wl,--emit-relocs -Wl,--mllvm=-align-all-functions=5 --verbose -DNDEBUG -O3 -falign-functions=32 -Wl,--mllvm=-relax-elf-relocations -fasynchronous-unwind-tables -fno-PIC -fno-PIE -fno-pic -fno-pie -Wl,--no-pie -fexceptions

rust1:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.rlib || :
	-@rm ./*.o || :
	-@rm ./*.old || :
	-@rm ./*.data || :
	-@rm ./*.profraw || :
	-@rm ./*.profdata || :
	-@rm ./*.perfdata || :
	-@rm ./*.rlink || :
	-@rm ./*.i || :
	-@rm ./*.a || :
	-@rm ./*.ll || :
	-@rm ./*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.ll || :
	-@rm ./*.txt || :
	-@rm ./*.dot || :
	-@rm ./*.yaml || :
	-@rm ./myopt* || :
	-@rm ./rsmain || :
	-@rm ./teste || :
	-@rm ./rsmain* || :
	-@rm ./*.fdata || :
	clang $(CFLAGS_GEN) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_GEN) -L. ./interesting.rs
	rustc $(COMMON_FLAGS_GEN) -o ./rsmain ./main.rs
# 	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
# 	sudo sysctl -w kernel.perf_event_max_stack=1000
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-1.perfdata" ./rsmain
# 	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
# 	sudo sysctl -w kernel.perf_event_max_stack=1000
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-2.perfdata" ./rsmain
# 	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
# 	sudo sysctl -w kernel.perf_event_max_stack=1000
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-3.perfdata" ./rsmain
# 	sudo chown boni:boni *.old || :
# 	sudo chown boni:boni *.data || :
# 	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-1.perfdata --out=samples-1.profraw
# 	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-2.perfdata --out=samples-2.profraw
# 	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-3.perfdata --out=samples-3.profraw
	./rsmain
	./rsmain
	./rsmain
	./rsmain
	./rsmain
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain


#    operations. Accounts for integer and floating-point operations]
#  br_inst_retired.all_branches
#    [All (macro) branch instructions retired Spec update: SKL091]
#  br_inst_retired.all_branches_pebs
#    [All (macro) branch instructions retired Spec update: SKL091 (Must be
#     precise)]
#  br_inst_retired.cond_ntaken
#    [Not taken branch instructions retired Spec update: SKL091]
#  br_inst_retired.conditional
#    [Conditional branch instructions retired Spec update: SKL091 (Precise
#     event)]
#  br_inst_retired.far_branch
#    [Far branch instructions retired Spec update: SKL091 (Precise event)]
#  br_inst_retired.near_call
#    [Direct and indirect near call instructions retired Spec update: SKL091
#     (Precise event)]
#  br_inst_retired.near_return
#    [Return instructions retired Spec update: SKL091 (Precise event)]
#  br_inst_retired.near_taken
#    [Taken branch instructions retired Spec update: SKL091 (Precise event)]
#  br_inst_retired.not_taken
#    [Not taken branch instructions retired Spec update: SKL091]


rust2:
	-@rm ./*.o || :
	-@rm ./*.rlib || :
	-@rm ./*.i || :
	-@rm ./*.a || :
	-@rm ./*.ll || :
	-@rm ./*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.ll || :
	-@rm ./*.txt || :
	-@rm ./*.dot || :
	-@rm ./*.yaml || :
	-@rm ./myopt* || :
	-@rm ./rsmain || :
	-@rm ./rsmain* || :
	-@rm ./*.fdata || :
	/usr/bin/llvm-profdata merge -o /var/tmp/pgo/rustmerged.profdata /var/tmp/pgo/*.profraw
	clang $(CFLAGS_USE) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_USE) -L. ./interesting.rs
	rustc $(COMMON_FLAGS_USE) -o ./rsmain ./main.rs
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain

rustc:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.rlib || :
	-@rm ./*.old || :
	-@rm ./*.data || :
	-@rm ./*.profraw || :
	-@rm ./*.profdata || :
	-@rm ./*.perfdata || :
	-@rm ./*.o || :
	-@rm ./*.i || :
	-@rm ./*.a || :
	-@rm ./*.ll || :
	-@rm ./*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.ll || :
	-@rm ./*.txt || :
	-@rm ./*.dot || :
	-@rm ./*.yaml || :
	-@rm ./myopt* || :
	-@rm ./rsmain || :
	-@rm ./rsmain* || :
	-@rm ./*.fdata || :
	-@rm ./teste || :
	-@rm ./*.profraw || :
	-@rm ./*.perfdata || :


perf:
	-@rm ./*.old || :
	-@rm ./*.data || :
	-@rm ./*.profraw || :
	-@rm ./*.profdata || :
	-@rm ./*.perfdata || :
	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
	sudo sysctl -w kernel.perf_event_max_stack=1000
	ocperf record --freq=max --buildid-all -g -b -o "samples-1.perfdata" ./rsmain
	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
	sudo sysctl -w kernel.perf_event_max_stack=1000
	ocperf record --freq=max --buildid-all -g -b -o "samples-2.perfdata" ./rsmain
	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
	sudo sysctl -w kernel.perf_event_max_stack=1000
	ocperf record --freq=max --buildid-all -g -b -o "samples-3.perfdata" ./rsmain
# 	ocperf record -b ./rsmain
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.data || :
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-1.perfdata --out=samples-1.profraw
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-2.perfdata --out=samples-2.profraw
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rsmain --profile=samples-3.perfdata --out=samples-3.profraw


tt1:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.o || :
	-@rm ./*.old || :
	-@rm ./*.data || :
	-@rm ./*.profraw || :
	-@rm ./*.profdata || :
	-@rm ./*.perfdata || :
	-@rm ./*.rlink || :
	-@rm ./*.i || :
	-@rm ./*.a || :
	-@rm ./*.ll || :
	-@rm ./*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.ll || :
	-@rm ./*.txt || :
	-@rm ./*.dot || :
	-@rm ./*.yaml || :
	-@rm ./myopt* || :
	-@rm ./rsmain || :
	-@rm ./teste || :
# 	clang++ -fuse-ld=lld -flto=thin -O3 -g -Wl,--no-rosegment -Wl,--build-id=sha1 -static -static-libstdc++ -static-libgcc -pthread ./main.cpp -o ./teste
	clang++ -fuse-ld=lld -flto=thin -O3 -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment -Wl,--build-id=sha1 -static -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables ./main.cpp -o ./teste
# 	sudo ocperf record --buildid-all -b -e br_inst_retired.near_taken:pp ./teste
# 	ocperf record --buildid-all -b -e br_inst_retired.near_taken:pp ./teste
# 	ocperf record --freq=max --buildid-all -g -b -e br_inst_retired.near_taken:pp ./teste
	ocperf record --freq=max --buildid-all -g -b -o "samples-1.perfdata" ./teste
	ocperf record --freq=max --buildid-all -g -b -o "samples-2.perfdata" ./teste
	ocperf record --freq=max --buildid-all -g -b -o "samples-3.perfdata" ./teste
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-1.perfdata" ./teste
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-2.perfdata" ./teste
# 	ocperf record --freq=max --buildid-all -g -b -o "samples-3.perfdata" ./teste
# 	$OCPERF record -b -g -e br_inst_retired.near_taken -o $CWD/$i.data -- $CWD/$i
# 	$OCPERF record -b -e br_inst_retired.near_taken -o $CWD/$SHORTNAME.data -- $COMMAND
# 	ocperf.py record -F max -o "samples-1.prof" -b -e br_inst_retired.near_taken:pp -- /path/to/fdo-trained/dosbox ARGS
# 	ocperf.py record -b -e BR_INST_RETIRED.ALL_BRANCHES:p program
# 	sudo sysctl -w kernel.perf_event_max_sample_rate=100000
# 	sudo sysctl -w kernel.perf_event_max_stack=1000
# 	ocperf record --buildid-all -b ./teste
	sudo chown boni:boni *.perfdata || :
	sudo chown boni:boni *.profraw || :
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/teste --profile=samples-1.perfdata --out=samples-1.profraw
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/teste --profile=samples-2.perfdata --out=samples-2.profraw
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/teste --profile=samples-3.perfdata --out=samples-3.profraw
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.perfdata || :
	sudo chown boni:boni *.profraw || :
	exa --long --all --icons ./teste
	ldd ./teste
	./teste

tt2:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.o || :
	-@rm ./*.rlink || :
	-@rm ./*.i || :
	-@rm ./*.a || :
	-@rm ./*.ll || :
	-@rm ./*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.bc || :
	-@rm /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/*.ll || :
	-@rm ./*.txt || :
	-@rm ./*.dot || :
	-@rm ./*.yaml || :
	-@rm ./myopt* || :
	-@rm ./rsmain || :
	-@rm ./teste || :
	/usr/bin/llvm-profdata merge --sample -o rustmerged.profdata *.profraw
# 	clang++ -fuse-ld=lld -flto=thin -O3 -g -Wl,--no-rosegment -Wl,--build-id=sha1 -static -static-libstdc++ -static-libgcc -pthread -fprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rustmerged.profdata ./main.cpp -o ./teste
	clang++ -fuse-ld=lld -flto=thin -O3 -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment -Wl,--build-id=sha1 -static -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables -fprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/rustmerged.profdata ./main.cpp -o ./teste
	exa --long --all --icons ./teste
	ldd ./teste
	./teste
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.perfdata || :
	sudo chown boni:boni *.profraw || :
