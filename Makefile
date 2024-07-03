REPO_DIR := $(shell pwd)
VENDOR_DIR := $(REPO_DIR)/external
LIBGIT2_DIR := $(VENDOR_DIR)/libgit2
LIBGIT2_BUILD_DIR := $(LIBGIT2_DIR)/build

help:
	@echo
	@echo "\x1b[1;34mSCRIPTS:\x1b[0m"
	@echo
	@echo "make \x1b[1mgo.build\x1b[0m                \x1b[2m# Build the Go project\x1b[0m"
	@echo "make \x1b[1mgo.clean\x1b[0m                \x1b[2m# Clean Go build artifacts\x1b[0m"
	@echo "make \x1b[1mvendors.libgit2\x1b[0m         \x1b[2m# Build libgit2 library\x1b[0m"
	@echo "make \x1b[1mvendors.libgit2.clean\x1b[0m   \x1b[2m# Clean libgit2 build artifacts\x1b[0m"
	@echo "make \x1b[1mtest\x1b[0m                    \x1b[2m# Run Go tests\x1b[0m"
	@echo "make \x1b[1mhelp\x1b[0m                    \x1b[2m# Show this help message\x1b[0m"
	@echo

.PHONY: vendors.libgit2
vendors.libgit2:
	@mkdir -p $(LIBGIT2_BUILD_DIR)
	@cd $(LIBGIT2_BUILD_DIR) && cmake \
		-DUSE_HTTPS=ON \
		-DBUILD_SHARED_LIBS=OFF \
		-DBUILD_TESTS=OFF \
		-DBUILD_CLI=OFF \
		-DREGEX_BACKEND=builtin \
		-DUSE_BUNDLED_ZLIB=ON \
		-DDEPRECATE_HARD=ON \
		-DCMAKE_BUILD_TYPE="RelWithDebInfo" \
		-DCMAKE_INSTALL_PREFIX=install \
		-DCMAKE_INSTALL_LIBDIR=lib \
		$(LIBGIT2_DIR)
	@cmake --build $(LIBGIT2_BUILD_DIR) --target install

.PHONY: vendors.libgit2.clean
vendors.libgit2.clean:
	@rm -rf $(LIBGIT2_DIR)/build

.PHONY: go.build
go.build:
	CGO_ENABLED=1 \
	CGO_CFLAGS="-I$(LIBGIT2_BUILD_DIR)/install/include" \
	CGO_LDFLAGS="-L$(LIBGIT2_BUILD_DIR)/install/lib" \
	go build ./...

.PHONY: go.clean
go.clean:
	go clean -i ./...

.PHONY: test
test:
	go test -v ./...
