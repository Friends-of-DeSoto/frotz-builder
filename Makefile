VERSION=2.52
# GOOS?=$(shell go env GOOS)
# GOARCH?=$(shell go env GOARCH)

build:
	git clone --branch $(VERSION) https://gitlab.com/DavidGriffith/frotz && \
		pushd frotz && \
		make dumb && \
		mv dfrotz /usr/local/bin/dfrotz-$(OS)-$(ARCH) && \
		popd


version:
	@echo $(VERSION)