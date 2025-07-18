include Makefile

#
# BPF Source file
#
TARGETS := kern/openssl_1_1_1a
TARGETS += kern/gotls
TARGETS += kern/gnutls_3_6_12

# Generate file name-scheme based on TARGETS
KERN_SOURCES = ${TARGETS:=_kern.c}
KERN_OBJECTS = ${KERN_SOURCES:.c=.o}


# CROSS_ARCH=arm64|arm64
CROSS_ARCH ?= amd64

$(KERN_OBJECTS): ${KERN_SOURCES} \
	| .checkver_$(CMD_CLANG) \
	.checkver_$(CMD_GO) \
	autogen
	$(CMD_CLANG) -D__TARGET_ARCH_$(LINUX_ARCH) \
		$(EXTRA_CFLAGS) \
		$(BPFHEADER) \
		-target bpfel -c $< -o $(subst kern/,user/bytecode/,$(subst .o,_core.o,$@)) \
		-fno-ident -fdebug-compilation-dir . -g -D__BPF_TARGET_MISSING="GCC error \"The eBPF is using target specific macros, please provide -target\"" \
		-MD -MP || exit 1


.PHONY: ebpf-custom
ebpf-custom: autogen $(KERN_OBJECTS)


CROSS_ARCH ?= amd64

.PHONY: assets-custom
assets-custom: .checkver_$(CMD_GO) ebpf-custom
	$(CMD_GO) run github.com/shuLhan/go-bindata/cmd/go-bindata $(IGNORE_LESS52) -pkg assets -o "assets/ebpf_probe_$(CROSS_ARCH).go" $(wildcard ./user/bytecode/*.o)

.PHONY: build-custom
build-custom: .checkver_$(CMD_GO) assets-custom
	$(call allow-override,VERSION_FLAG,$(UNAME_R))