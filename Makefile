.PHONY: fmt
fmt:
	stylua --config-path stylua.toml --glob 'lua/**/*.lua' -- lua

.PHONY: lint
lint:
	luacheck ./lua

.PHONY: test
test:
	vusted --output=gtest ./lua

