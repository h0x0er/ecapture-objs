include Makefile

.PHONY: build-local
build-local: .checkver_$(CMD_GO) assets
	$(call allow-override,VERSION_FLAG,$(UNAME_R))

