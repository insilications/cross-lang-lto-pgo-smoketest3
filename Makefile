unexport LLVM_PROFILE_FILE


PASS_MANAGER_RUST=-Clink-arg=-Wl,--lto-legacy-pass-manager -Clink-arg=-flegacy-pass-manager -Znew-llvm-pass-manager=no

RUST_PGO_GEN=-Clink-arg=-fprofile-generate=/var/tmp/pgo -Cprofile-generate=/var/tmp/pgo -Clink-arg=-fprofile-update=atomic
# RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo
COMMON_FLAGS_GEN=$(RUST_PGO_GEN) $(PASS_MANAGER_RUST) -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=32 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Cstrip=none -Cdebuginfo=2 -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=5000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=5000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=5000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=5000 -Clink-arg=-Wl,--mllvm=-inline-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=5000 -Cllvm-args=-inline-threshold=5000 -Cinline-threshold=5000 -Cforce-unwind-tables=on
#-Ctarget-feature=+crt-static -Crelocation-model=static -Csave-temps=yes

RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-update=atomic
# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata

COMMON_FLAGS_USE=$(RUST_PGO_USE) $(PASS_MANAGER_RUST) -Clto=thin -Clinker-plugin-lto=on -Clink-arg=-flto=thin -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=32 -Cpanic=abort -Cembed-bitcode=yes -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. --print link-args -Ctarget-feature=+crt-static -Crelocation-model=static -Cstrip=debuginfo -Cdebuginfo=2 -Clink-arg=-fsave-optimization-record=yaml -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native -Ctarget-cpu=native -Clink-arg=-march=native -Clink-arg=-mtune=native -Zunstable-options -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=5000 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=5000 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=5000 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=5000 -Clink-arg=-Wl,--mllvm=-inline-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=5000 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=5000 -Cllvm-args=-inline-threshold=5000 -Cinline-threshold=5000 -Zprint-llvm-passes=yes -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments -Cforce-unwind-tables=on

# PASS_MANAGER_CFLAGS=-enable-new-pm=1 -fno-legacy-pass-manager -Wl,-mllvm,-enable-new-pm=1
PASS_MANAGER_CFLAGS=-flegacy-pass-manager
CFLAGS_PGO_GEN=-fprofile-generate=/var/tmp/pgo -fprofile-update=atomic
CFLAGS_GEN=$(CFLAGS_PGO_GEN) $(PASS_MANAGER_CFLAGS) -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native

CFLAGS_PGO_USE=-fprofile-use=/var/tmp/pgo/merged.profdata -fprofile-update=atomic
CFLAGS_USE=$(CFLAGS_PGO_USE) $(PASS_MANAGER_CFLAGS) -flto=thin -O3 -g -fuse-ld=lld --verbose -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native

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
