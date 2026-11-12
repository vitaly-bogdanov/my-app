GOLANGCI_LINT_VERSION := 2.15.0
BIN_DIR := .tools
GOLANGCI_LINT := $(BIN_DIR)/golangci-lint

.PHONY: build test lint docker bench ci tools

build:
	go build ./...

test:
	go test -coverprofile=coverage.out ./...
	go tool cover -func=coverage.out

tools: $(BIN_DIR)/.golangci-lint-v$(GOLANGCI_LINT_VERSION)

$(BIN_DIR)/.golangci-lint-v$(GOLANGCI_LINT_VERSION):
	mkdir -p $(BIN_DIR)
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(BIN_DIR) v$(GOLANGCI_LINT_VERSION)
	rm -f $(BIN_DIR)/.golangci-lint-v*
	touch $@

lint: tools
	$(GOLANGCI_LINT) run ./...

docker:
	docker build -t myapp:ci .

bench:
	go test -bench=. -benchmem ./...

ci: build test lint docker
