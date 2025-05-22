include Makefile

CROSS_ARCH ?= amd64

.PHONY: assets-custom
assets-custom: .checkver_$(CMD_GO) ebpf
	$(CMD_GO) run github.com/shuLhan/go-bindata/cmd/go-bindata $(IGNORE_LESS52) -pkg assets -o "assets/ebpf_probe_$(CROSS_ARCH).go" $(wildcard ./user/bytecode/*.o)

.PHONY: build-custom
build-custom: .checkver_$(CMD_GO) assets-custom
	$(call allow-override,VERSION_FLAG,$(UNAME_R))