unexport LLVM_PROFILE_FILE


# PASS_MANAGER_RUST=-Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
# PASS_MANAGER_RUST=-Clink-arg=-Wl,--lto-legacy-pass-manager -Clink-arg=-flegacy-pass-manager -Znew-llvm-pass-manager=no -Clink-args='-mllvm -enable-new-pm=0'
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=no -Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-fno-legacy-pass-manager
# -Cforce-unwind-tables=on
# PASS_MANAGER_RUST=-Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral
RUST_PGO_GEN=-Clink-arg=-fprofile-generate=/var/tmp/pgo -Cprofile-generate=/var/tmp/pgo
# RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-update=atomic
COMMON_FLAGS_GEN=$(RUST_PGO_GEN) $(PASS_MANAGER_RUST) -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=34 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Cstrip=none -Cdebuginfo=2 -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=19000 -Cllvm-args=-inline-threshold=19000 -Cinline-threshold=19000  -Zprint-llvm-passes=yes -Zmir-opt-level=4 -Zinline-mir=yes -Zinline-mir-threshold=500  -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions -Cllvm-args=-import-instr-evolution-factor=2 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=6 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1
#-Ctarget-feature=+crt-static -Crelocation-model=static -Csave-temps=yes

RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-use=/var/tmp/pgo/merged.profdata
# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-update=atomic

COMMON_FLAGS_USE=$(RUST_PGO_USE) $(PASS_MANAGER_RUST) -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=34 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Cstrip=debuginfo -Cdebuginfo=2 -Clink-arg=-fsave-optimization-record=yaml -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--mllvm=-inline-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=19000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=19000 -Cllvm-args=-inline-threshold=19000 -Cinline-threshold=19000 -Zprint-llvm-passes=no   -Zmir-opt-level=4 -Zinline-mir=yes -Zinline-mir-threshold=500  -Cllvm-args=-import-instr-limit=33000 -Clink-arg=-Wl,--mllvm=-import-instr-limit=33000 -Cllvm-args=-import-all-index -Clink-arg=-Wl,--mllvm=-import-all-index -Cllvm-args=-import-full-type-definitions -Clink-arg=-Wl,--mllvm=-import-full-type-definitions  -Cllvm-args=-import-instr-evolution-factor=6 -Clink-arg=-Wl,--mllvm=-import-instr-evolution-factor=2 -Clink-arg=-fwhole-program-vtables -Clink-arg=-fforce-emit-vtables -Clink-arg=-Wl,--lto-whole-program-visibility -Cllvm-args=-intra-scc-cost-multiplier=1 -Clink-arg=-Wl,--mllvm=-intra-scc-cost-multiplier=1

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
CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo
CFLAGS_GEN=$(CFLAGS_PGO_GEN) $(PASS_MANAGER_CFLAGS) -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -fwhole-program-vtables -fforce-emit-vtables

CFLAGS_PGO_USE=-fprofile-use=/var/tmp/pgo/merged.profdata -fprofile-update=atomic
CFLAGS_USE=$(CFLAGS_PGO_USE) $(PASS_MANAGER_CFLAGS) -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -fwhole-program-vtables -fforce-emit-vtables

rust1:
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
	clang $(CFLAGS_GEN) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_GEN) -o ./rsmain ./main.rs
	./rsmain
	./rsmain
	./rsmain
	./rsmain
	./rsmain
	./rsmain
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain

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
	/usr/bin/llvm-profdata merge -o /var/tmp/pgo/merged.profdata /var/tmp/pgo/*.profraw
	clang $(CFLAGS_USE) ./clib.c -c -o ./clib.o
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_USE) -o ./rsmain ./main.rs
# 	-@find . -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
# 	-@find /usr/lib64/rustlib/x86_64-unknown-linux-gnu/lib/ -type f \( -iname \*.bc -o -iname \*.o \) -exec llvm-dis "{}" \; || :
	exa --long --all --icons ./rsmain
	ldd ./rsmain

rustc:
	-@rm /var/tmp/pgo/* || :
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
