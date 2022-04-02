# needs-matching-clang

# This test makes sure that cross-language inlining can be used in conjunction
# with profile-guided optimization. The test only tests that the whole workflow
# can be executed without anything crashing. It does not test whether PGO or
# xLTO have any specific effect on the generated code.
#
# -include ../tools.mk

# -Cremark=all -Clink-arg=-Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3 -Cstrip=debuginfo -Cdebuginfo=2
#  -g -Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3

unexport LLVM_PROFILE_FILE

# -Clink-arg=--save-temps -Clink-arg=-Wl,--save-temps
# -Csave-temps=yes --emit=llvm-ir,link
#  -Clink-arg=-Wl,--lto-newpm-passes=cg-profile
#  -Clto=fat
# export LLVM_PROFILE_FILE=/var/tmp/pgo/default-%p-%m.profraw
# -Clink-arg=-fsave-optimization-record -Clink-arg=-Wl,-fsave-optimization-record
# -Clink-arg=-Rpass=.* -Clink-arg=-Rpass-missed=.* -Clink-arg=-Rpass-analysis=.*
# -Clink-arg=-Wl,--plugin-opt=opt-remarks-filename=myopt.yaml -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.*
# -Clink-arg=-Wl,--plugin-opt=save-temps
# -Clink-arg=--verbose
# -Clink-arg=-fdiagnostics-show-hotness
# -Clink-arg=-foptimization-record-passes=.*
# -Clink-arg=-Wl,--plugin-opt=debug-pass-manager
# -Clink-arg=-Wl,--lto-whole-program-visibility
# -Clink-arg=-Wl,--mllvm=-inline-deferral
# -Clink-arg=-Wl,--plugin-opt=-inline-cost-full
#  -Clink-arg=-fno-legacy-pass-manager
# -Zcombine-cgu=yes
# -Clink-arg=-Wl,--plugin-opt=debug-pass-manager -Zprint-llvm-passes=yes
# -Clink-arg=-Wl,--allow-multiple-definition
# -Clink-arg=-Wl,--plugin-opt=debug-pass-manager -Clink-arg=-Wl,--lto-debug-pass-manager -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
# PASS_MANAGER_RUST=-Clink-arg=-Wl,--plugin-opt=new-pass-manager -Clink-arg=-fno-legacy-pass-manager -Znew-llvm-pass-manager=yes -Clink-arg=-Wl,--plugin-opt=-enable-npm-pgo-inline-deferral -Clink-args='-mllvm -enable-new-pm=1'
PASS_MANAGER_RUST=-Clink-arg=-Wl,--lto-legacy-pass-manager -Clink-arg=-flegacy-pass-manager -Znew-llvm-pass-manager=no -Clink-args='-mllvm -enable-new-pm=0'
# RUST_PGO_GEN=-Clink-arg=-fprofile-generate=/var/tmp/pgo -Cprofile-generate=/var/tmp/pgo
RUST_PGO_GEN=-Cprofile-generate=/var/tmp/pgo
COMMON_FLAGS_GEN=$(RUST_PGO_GEN) $(PASS_MANAGER_RUST) -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments -Clinker-plugin-lto=on -Zrelro-level=full -Clink-arg=-flto=full -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=1400 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=1400 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=1400 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=1400 -Clink-arg=-Wl,--mllvm=-inline-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=1400 -Cllvm-args=-inline-threshold=1400 -Cinline-threshold=1400 -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. -Clink-arg= -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=4 -Cpanic=abort -Clto=fat -Ctarget-feature=+crt-static -Crelocation-model=static -Csave-temps=yes -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cstrip=debuginfo -Cdebuginfo=2 -Clink-arg=-fsave-optimization-record=yaml -Clink-arg=-foptimization-record-passes=.* -Clink-arg=-Rpass=.* -Clink-arg=-Rpass-missed=.* -Clink-arg=-Rpass-analysis=.* -Clink-arg=-fdiagnostics-show-hotness -Clink-arg=-Wl,--plugin-opt=opt-remarks-filename=myopt.yaml -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.*  -Clink-arg=-fsave-optimization-record=yaml -Clink-arg=-foptimization-record-passes=.* -Clink-arg=-Rpass=.* -Clink-arg=-Rpass-missed=.* -Clink-arg=-Rpass-analysis=.* -Clink-arg=-fdiagnostics-show-hotness -Clink-arg=-Wl,--plugin-opt=opt-remarks-filename=myopt.yaml -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.* -Clink-arg=-Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=off -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O2 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Crelocation-model=static -Cforce-frame-pointers=off -Cforce-unwind-tables=off -Cpanic=abort -Clink-arg=-Wl,-plugin-opt=-import-instr-limit=400 -Clink-arg=-fwhole-program-vtables -Clink-arg=-Wl,--lto-whole-program-visibility -Zfunction-sections=no -Zprint-llvm-passes=no -Zcombine-cgu=yes -Clink-arg=-Wl,--mllvm=-inline-deferral -Cembed-bitcode=yes -Zthinlto=off --print link-args
# -Zcombine-cgu=yes
# RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata -Clink-arg=-fprofile-use=/var/tmp/pgo/merged.profdata
RUST_PGO_USE=-Cprofile-use=/var/tmp/pgo/merged.profdata

# --emit=llvm-bc,llvm-ir,link  -Cno-prepopulate-passes
# -Clink-args='-Xclang -fdebug-pass-manager' -Clink-arg=-Wl,--lto-debug-pass-manager  -Clink-arg=-Wl,--plugin-opt=-debug-pass=Structure -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments
# -Zlink-only -Zno-link
# -Cno-prepopulate-passes -Cpasses=name-anon-globals
# -Clink-arg=-Wl,--plugin-opt=debug-pass-manager -Clink-arg=-Wl,--lto-debug-pass-manager
#
COMMON_FLAGS_USE=$(RUST_PGO_USE) $(PASS_MANAGER_RUST) -Clinker-plugin-lto=on -Clink-arg=-Wl,--plugin-opt=-debug-pass=Arguments -Zrelro-level=full -Clink-arg=-flto=full -Cprefer-dynamic=no -Clink-arg=-Wl,--mllvm=-inlinehint-threshold=1400 -Clink-arg=-Wl,--mllvm=-inlinedefault-threshold=1400 -Clink-arg=-Wl,--mllvm=-inlinecold-threshold=1400 -Clink-arg=-Wl,--mllvm=-inline-cost-full -Clink-arg=-Wl,--mllvm=-inline-cold-callsite-threshold=1400 -Clink-arg=-Wl,--mllvm=-inline-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinehint-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinedefault-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inlinecold-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inline-cold-callsite-threshold=1400 -Clink-arg=-Wl,--plugin-opt=-inline-threshold=1400 -Cllvm-args=-inline-threshold=1400 -Cinline-threshold=1400 -L. --verbose -Clink-arg=--verbose -Clink-arg=-Wl,--verbose -Clink-arg=-L. -Clink-arg= -Zunstable-options -Clinker=clang -Clink-arg=-fuse-ld=lld -Copt-level=3 -Ccodegen-units=4 -Cpanic=abort -Clto=fat -Ctarget-feature=+crt-static -Znew-llvm-pass-manager=yes -Crelocation-model=static -Csave-temps=no -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps -Cstrip=debuginfo -Cdebuginfo=2 -Clink-arg=-fsave-optimization-record=yaml -Clink-arg=-foptimization-record-passes=.* -Clink-arg=-Rpass=.* -Clink-arg=-Rpass-missed=.* -Clink-arg=-Rpass-analysis=.* -Clink-arg=-fdiagnostics-show-hotness -Clink-arg=-Wl,--plugin-opt=opt-remarks-filename=myopt.yaml -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.* -Clink-arg=-fsave-optimization-record=yaml -Clink-arg=-foptimization-record-passes=.* -Clink-arg=-Rpass=.* -Clink-arg=-Rpass-missed=.* -Clink-arg=-Rpass-analysis=.* -Clink-arg=-fdiagnostics-show-hotness -Clink-arg=-Wl,--plugin-opt=opt-remarks-filename=myopt.yaml -Clink-arg=-Wl,--plugin-opt=opt-remarks-passes=.* -Clink-arg=-Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3 -Ctarget-cpu=native -Cprefer-dynamic=no -Zplt=off -Ztune-cpu=native -Clink-arg=-Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Clink-arg=-Wl,--lto-O3 -Clink-arg=-Wl,-O2 -Clink-arg=-O3 -Clink-arg=-mno-vzeroupper -Clink-arg=-march=native -Clink-arg=-mtune=native -Crelocation-model=static -Cforce-frame-pointers=off -Cforce-unwind-tables=off -Cpanic=abort -Clink-arg=-Wl,-plugin-opt=-import-instr-limit=400 -Clink-arg=-fwhole-program-vtables -Clink-arg=-Wl,--lto-whole-program-visibility -Zfunction-sections=no -Zprint-llvm-passes=yes -Zcombine-cgu=yes -Clink-arg=-Wl,--mllvm=-inline-deferral -Cembed-bitcode=yes -Zthinlto=off --print link-args
#  -Clink-args='-Wl,--plugin-opt=passes=pgo-instr-use
# -Clink-arg=-Wl,--lto-newpm-passes=pgo-instr-use
#-Clink-arg=-Wl,--lto-newpm-passes=pgo-instr-use -Clink-arg=-Wl,--mllvm=-pgo-test-profile-file=/var/tmp/pgo/merged.profdata
# -Clink-arg=-Wl,--plugin-opt=save-temps -Clink-arg=-Wl,--save-temps -Clink-arg=--save-temps
# -Clink-arg=-Wl,--mllvm=-pgo-test-profile-file=/var/tmp/pgo/merged.profdata
# -Clink-arg=-Wl,--lto-newpm-passes=pgo-instr-use
# -Clink-arg=-fprofile-use=/var/tmp/pgo/merged.profdata
# -Clink-arg=-Wl,--mllvm=-pgo-test-profile-file=/var/tmp/pgo/merged.profdata
#-Clink-arg=-Wl,--lto-newpm-passes=pgo-instr-use
#-Zthinlto=on
#  -Cremark=all
#-Zpre-link-arg=-Wl,--lto-newpm-passes=cg-profile
# -Zpre-link-arg=-Wl,--lto-newpm-passes=inline
# -Zthinlto=no
# -Clink-arg=-Wl,--lto-newpm-passes=cg-profile -Clink-arg=-Wl,--lto-newpm-passes=inline -Clink-arg=-Wl,--mllvm=-disable-verify -Clink-arg=-Wl,--plugin-opt=-disable-verify -Clink-arg=-Wl,--plugin-opt=disable-verify

# PASS_MANAGER_CFLAGS=-enable-new-pm=1 -fno-legacy-pass-manager -Wl,-mllvm,-enable-new-pm=1
PASS_MANAGER_CFLAGS=-mllvm -enable-new-pm=0 -flegacy-pass-manager -Wl,-mllvm,-enable-new-pm=0
CFLAGS_PGO_GEN=-mllvm -fprofile-generate=/var/tmp/pgo
# -mllvm -debug-pass=Arguments
CFLAGS_GEN=$(CFLAGS_PGO_GEN) $(PASS_MANAGER_CFLAGS) -flto=full -O3 -g -fuse-ld=lld --verbose --save-temps -Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3 -mllvm -inline-threshold=1400 -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -fembed-bitcode -Wl,--lto-partitions=1 -Wl,--lto-O3 -Wl,-O2 -O3 -mno-vzeroupper -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -fuse-ld=lld -Wl,--as-needed -Wl,--build-id=sha1 -Wl,--enable-new-dtags -Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -fasynchronous-unwind-tables -static-libstdc++ -static-libgcc -pthread -pipe -mllvm -x86-use-vzeroupper=0

# -fwhole-program-vtables -fforce-emit-vtables
CFLAGS_PGO_USE=-fprofile-use=/var/tmp/pgo/merged.profdata
CFLAGS_USE=$(CFLAGS_PGO_USE) $(PASS_MANAGER_CFLAGS) -flto=full -O3 -g -fuse-ld=lld --verbose --save-temps -Wl,-O3,--sort-common,--as-needed,--lto-partitions=1,--lto-O3 -mllvm -inline-threshold=1400 -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -g -Wall -Wl,-mllvm,-x86-use-vzeroupper=0 -fembed-bitcode -Wl,--lto-partitions=1 -Wl,--lto-O3 -Wl,-O2 -O3 -mno-vzeroupper -march=native -mcpu=native -mtune=native -Wl,-mllvm,-mcpu=native -fuse-ld=lld -Wl,--as-needed -Wl,--build-id=sha1 -Wl,--enable-new-dtags -Wl,-plugin-opt=O3,-plugin-opt=mcpu=native,-plugin-opt=lto-partitions=1 -Wl,-z,now,-z,relro,-z,max-page-size=0x1000,-z,separate-code -Wno-error -mprefer-vector-width=256 -falign-functions=32 -fno-semantic-interposition -Wl,-Bsymbolic-functions -fno-stack-protector -fno-trapping-math -fno-math-errno -ftree-slp-vectorize -ftree-vectorize -feliminate-unused-debug-types -fno-plt -Wno-error -Wp,-D_REENTRANT -fvisibility-inlines-hidden -fomit-frame-pointer -fasynchronous-unwind-tables -static-libstdc++ -static-libgcc -pthread -pipe -mllvm -x86-use-vzeroupper=0

# LLVM doesn't support instrumenting binaries that use SEH:
# https://bugs.llvm.org/show_bug.cgi?id=41279
#
# Things work fine with -Cpanic=abort though.
# ifdef IS_MSVC
# COMMON_FLAGS+=
# endif

# all: cpp-executable rust-executable

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
	clang ./clib.c -c -o ./clib.o $(CFLAGS_GEN)
	llvm-ar crus ./libxyz.a ./clib.o
	rustc $(COMMON_FLAGS_GEN) -o ./rsmain ./main.rs
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
	clang ./clib.c -c -o ./clib.o $(CFLAGS_USE)
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
