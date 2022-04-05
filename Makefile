unexport LLVM_PROFILE_FILE


# PASS_MANAGER_RUST=-Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
# PASS_MANAGER_RUST=-Clink-arg=-Wl,--lto-legacy-pass-manager -Clink-arg=-flegacy-pass-manager -Znew-llvm-pass-manager=no -Clink-args='-mllvm -enable-new-pm=0'
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=no -Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-fno-legacy-pass-manager
# -Cforce-unwind-tables=on
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral
# RUST_PGO_GEN=-Clink-arg=-fprofile-generate=/var/tmp/pgo -Cprofile-generate=/var/tmp/pgo
RUST_PGO_GEN=-Zdebug-info-for-profiling=yes -Clink-arg=-g -Clink-arg=-Wl,--no-rosegment -Clink-arg=-fprofile-update=atomic
# RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-update=atomic
COMMON_FLAGS_GEN=$(RUST_PGO_GEN) $(PASS_MANAGER_RUST) -Clto=fat -Clinker-plugin-lto=on -Clink-arg=-flto=full -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=34 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=19000 -Cllvm-args=-inline-threshold=19000 -Cinline-threshold=19000  -Zprint-llvm-passes=yes -Zmir-opt-level=4 -Zinline-mir=yes -Zinline-mir-threshold=500  -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions -Cllvm-args=-import-instr-evolution-factor=2 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=6 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-Wl,--lto-unique-basic-block-section-names -Clink-arg=-funique-internal-linkage-names -Clink-arg=-Wl,--lto-basic-block-sections=labels -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1  -Zthinlto=no -Cforce-unwind-tables=on -Clinker-plugin-lto=on -Clto=fat -Clink-arg=-flto=full -Zunstable-options -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Zrelro-level=full -Zverify-llvm-ir=yes -Clink-arg=--verbose -Cllvm-args=--x86-use-vzeroupper=0 -Clink-self-contained=off -Coverflow-checks=off -Cstrip=none -Cdebug-assertions=yes -Cdebuginfo=2 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=off -Ztune-cpu=native -Copt-level=3 -Ccodegen-units=1 -Cembed-bitcode=yes -Ctarget-feature=+crt-static -Ctarget-feature=-vzeroupper -Crelocation-model=static -Cforce-frame-pointers=off -Cpanic=abort -Clinker=clang -Clink-arg=-Wno-unused-command-line-argument -Clink-arg=-Wall -Clink-arg=-Wl,--lto-partitions=1 -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O2 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Clink-arg=-fuse-ld=lld -Clink-arg=-Wl,--as-needed -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-mllvm,-x86-use-vzeroupper=0 -Clink-arg=-Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Clink-arg=-Wno-error -Clink-arg=-mprefer-vector-width=256 -Clink-arg=-falign-functions=32 -Clink-arg=-fno-semantic-interposition -Clink-arg=-Wl,-Bsymbolic-functions -Clink-arg=-fno-stack-protector -Clink-arg=-fno-trapping-math -Clink-arg=-fno-math-errno -Clink-arg=-ftree-slp-vectorize -Clink-arg=-ftree-vectorize -Clink-arg=-feliminate-unused-debug-types -Clink-arg=-fno-plt -Clink-arg=-Wno-error -Clink-arg=-Wp,-D_REENTRANT -Clink-arg=-fvisibility-inlines-hidden -Clink-arg=-fomit-frame-pointer -Clink-arg=-static-libstdc++ -Clink-arg=-static-libgcc -Clink-arg=-pthread  -Clink-arg=-gdwarf-4 -Cllvm-args=--dwarf-version=4 -Clink-arg=-Wl,--build-id=sha1 -Clink-arg=-fasynchronous-unwind-tables
#-Ctarget-feature=+crt-static -Crelocation-model=static -Csave-temps=yes

# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-use=/var/tmp/pgo/merged.profdata
RUST_PGO_USE=-Zprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/merged.data -Clink-arg=-g  -Clink-arg=-Wl,--no-rosegment -Clink-arg=-fprofile-update=atomic
# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-update=atomic

COMMON_FLAGS_USE=$(RUST_PGO_USE) $(PASS_MANAGER_RUST) -Clto=fat -Clinker-plugin-lto=on -Clink-arg=-flto=full -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=34 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Clink-arg=-fsave-optimization-record=yaml -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=19000 -Cllvm-args=-inline-threshold=19000 -Cinline-threshold=19000 -Zprint-llvm-passes=no   -Zmir-opt-level=4 -Zinline-mir=yes -Zinline-mir-threshold=500  -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions  -Cllvm-args=-import-instr-evolution-factor=6 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=2 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-funique-internal-linkage-names -Clink-arg=-Wl,--lto-basic-block-sections=labels -Clink-arg=-Wl,--lto-unique-basic-block-section-names -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1  -Zthinlto=no -Cforce-unwind-tables=on -Clinker-plugin-lto=on -Clto=fat -Clink-arg=-flto=full -Zunstable-options -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Zrelro-level=full -Zverify-llvm-ir=yes -Clink-arg=--verbose -Cllvm-args=--x86-use-vzeroupper=0 -Clink-self-contained=off -Coverflow-checks=off -Cstrip=none -Cdebug-assertions=yes -Cdebuginfo=2 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=off -Ztune-cpu=native -Copt-level=3 -Ccodegen-units=1 -Cembed-bitcode=yes -Ctarget-feature=+crt-static -Ctarget-feature=-vzeroupper -Crelocation-model=static -Cforce-frame-pointers=off -Cpanic=abort -Clinker=clang -Clink-arg=-Wno-unused-command-line-argument -Clink-arg=-Wall -Clink-arg=-Wl,--lto-partitions=1 -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O2 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Clink-arg=-fuse-ld=lld -Clink-arg=-Wl,--as-needed -Clink-arg=-Wl,--enable-new-dtags -Clink-arg=-Wl,-mllvm,-x86-use-vzeroupper=0 -Clink-arg=-Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Clink-arg=-Wno-error -Clink-arg=-mprefer-vector-width=256 -Clink-arg=-falign-functions=32 -Clink-arg=-fno-semantic-interposition -Clink-arg=-Wl,-Bsymbolic-functions -Clink-arg=-fno-stack-protector -Clink-arg=-fno-trapping-math -Clink-arg=-fno-math-errno -Clink-arg=-ftree-slp-vectorize -Clink-arg=-ftree-vectorize -Clink-arg=-feliminate-unused-debug-types -Clink-arg=-fno-plt -Clink-arg=-Wno-error -Clink-arg=-Wp,-D_REENTRANT -Clink-arg=-fvisibility-inlines-hidden -Clink-arg=-fomit-frame-pointer -Clink-arg=-static-libstdc++ -Clink-arg=-static-libgcc -Clink-arg=-pthread  -Clink-arg=-gdwarf-4 -Cllvm-args=--dwarf-version=4 -Clink-arg=-Wl,--build-id=sha1 -Clink-arg=-fasynchronous-unwind-tables -Cremark=all

# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments -Clink-arg=-Wl,--plugin-opt=debug-pass-manager
# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
#-Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments

#  -Clink-arg=-Wl,--plugin-opt=debug-pass-manager
#"-Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)"
# "-Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)"
# -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
# -Clink-arg=-Wl,--lto-newpm-passes=cgscc(no-op-cgscc)

# PASS_MANAGER_CFLAGS=-enable-new-pm=1 -fno-legacy-pass-manager -Wl,-mllvm,-enable-new-pm=1
# PASS_MANAGER_CFLAGS=-flegacy-pass-manager
PASS_MANAGER_CFLAGS=-fno-legacy-pass-manager
# CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo -fprofile-update=atomic
# CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo
CFLAGS_PGO_GEN=-Wl,--no-rosegment -fprofile-update=atomic
CFLAGS_GEN=$(CFLAGS_PGO_GEN) $(PASS_MANAGER_CFLAGS) -flto=full -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,--lto-basic-block-sections=labels -Wl,--lto-unique-basic-block-section-names -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables  -Wno-unused-command-line-argument -fno-legacy-pass-manager -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -mllvm -x86-use-vzeroupper=0 -flto=full -fembed-bitcode -Wl,--lto-partitions=1 -Wl,--lto-O3 -Wl,-O2 -O3 -mno-vzeroupper -march=native -mtune=native -fuse-ld=lld -Wl,--as-needed -Wl,--enable-new-dtags -Wl,-plugin-opt=O3,-plugin-opt=lto-partitions=1 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -pipe  -gdwarf-4

# CFLAGS_PGO_USE=-fprofile-use=/var/tmp/pgo/merged.profdata -fprofile-update=atomic
CFLAGS_PGO_USE=-fprofile-sample-use=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/merged.data -Wl,--no-rosegment -fprofile-update=atomic
CFLAGS_USE=$(CFLAGS_PGO_USE) $(PASS_MANAGER_CFLAGS) -flto=full -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,--lto-basic-block-sections=labels -Wl,--lto-unique-basic-block-section-names -Wl,--lto-whole-program-visibility -fwhole-program-vtables -fforce-emit-vtables  -Wno-unused-command-line-argument -fno-legacy-pass-manager -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -mllvm -x86-use-vzeroupper=0 -flto=full -fembed-bitcode -Wl,--lto-partitions=1 -Wl,--lto-O3 -Wl,-O2 -O3 -mno-vzeroupper -march=native -mtune=native -fuse-ld=lld -Wl,--as-needed -Wl,--enable-new-dtags -Wl,-plugin-opt=O3,-plugin-opt=lto-partitions=1 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables -pipe  -gdwarf-4

rust1:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.o || :
	-@rm ./*.old || :
	-@rm ./*.data || :
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
	clang $(CFLAGS_GEN) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_GEN) -o ./rsmain ./main.rs
	sudo ocperf record --buildid-all -b ./rsmain
	ocperf record --buildid-all -b ./rsmain
# 	ocperf record -b ./rsmain
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.data || :
	/usr/bin/create_llvm_prof --binary=./rsmain --profile=perf.data --out=merged.data
# 	./rsmain
# 	./rsmain
# 	./rsmain
# 	./rsmain
# 	./rsmain
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain


#       operations. Accounts for integer and floating-point operations]
#   br_inst_retired.all_branches
#        [All (macro) branch instructions retired Spec update: SKL091]
#   br_inst_retired.all_branches_pebs
#        [All (macro) branch instructions retired Spec update: SKL091 (Must be
#         precise)]
#   br_inst_retired.cond_ntaken
#        [Not taken branch instructions retired Spec update: SKL091]
#   br_inst_retired.conditional
#        [Conditional branch instructions retired Spec update: SKL091 (Precise
#         event)]
#   br_inst_retired.far_branch
#        [Far branch instructions retired Spec update: SKL091 (Precise event)]
#   br_inst_retired.near_call
#        [Direct and indirect near call instructions retired Spec update: SKL091
#         (Precise event)]
#   br_inst_retired.near_return
#        [Return instructions retired Spec update: SKL091 (Precise event)]
#   br_inst_retired.near_taken
#        [Taken branch instructions retired Spec update: SKL091 (Precise event)]
#   br_inst_retired.not_taken
#        [Not taken branch instructions retired Spec update: SKL091]


rust2:
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
# 	/usr/bin/llvm-profdata merge -o /var/tmp/pgo/merged.profdata /var/tmp/pgo/*.profraw
	clang $(CFLAGS_USE) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_USE) -o ./rsmain ./main.rs
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain

rustc:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.old || :
	-@rm ./*.data || :
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
	-@rm ./teste || :



tt1:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.o || :
	-@rm ./*.old || :
	-@rm ./*.data || :
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
	clang++ -fuse-ld=lld -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment -Wl,--build-id=sha1 -funique-internal-linkage-names -fbasic-block-sections=labels -static -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables ./main.cpp -o ./teste
# 	clang++ -fuse-ld=lld -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment ./main.cpp -o ./teste
# 	perf record --no-buildid --no-buildid-cache --branch-any ./rsmain
	sudo ocperf record --buildid-all -b ./teste
	ocperf record --buildid-all -b ./teste
	sudo chown boni:boni perf.data || :
# 	--buildid-all --buildid-mmap --no-buildid  --no-buildid-cache
# 	perf record --buildid-all --branch-filter any,u ./teste
# 	/usr/bin/create_llvm_prof --binary=./rsmain --out=merged.profdata
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/teste --profile=perf.data --out=merged.data
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.data || :

tt2:
	-@rm /var/tmp/pgo/* || :
	-@rm ./*.o || :
	-@rm ./*.old || :
	-@rm ./*.data || :
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
	clang++ -fuse-ld=lld -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment -Wl,--build-id=sha1 -funique-internal-linkage-names -fbasic-block-sections=labels -static -static-libstdc++ -static-libgcc -pthread -fasynchronous-unwind-tables ./main.cpp -o ./teste
# 	clang++ -fuse-ld=lld -gdwarf-4 -g -gline-tables-only -Wl,--no-rosegment ./main.cpp -o ./teste
# 	perf record --no-buildid --no-buildid-cache --branch-any ./rsmain
	sudo ocperf record --buildid-all -b ./teste
	ocperf record --buildid-all -b ./teste
	sudo chown boni:boni perf.data || :
# 	--buildid-all --buildid-mmap --no-buildid  --no-buildid-cache
# 	perf record --buildid-all --branch-filter any,u ./teste
# 	/usr/bin/create_llvm_prof --binary=./rsmain --out=merged.profdata
	/usr/bin/create_llvm_prof --binary=/insilications/build/git-clr/cross-lang-lto-pgo-smoketest3/teste --profile=perf.data --out=merged.data
	sudo chown boni:boni *.old || :
	sudo chown boni:boni *.data || :
