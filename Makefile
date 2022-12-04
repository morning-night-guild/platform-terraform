export
ENV := dev

.PHONY: init
init: ## Terraform initialize
	@terraform init

.PHONY: fmt
fmt: ## Terraform format
	@terraform fmt -recursive

.PHONY: lint
lint: ## Terraform format check and terraform validate
	@terraform fmt -recursive -check
	@terraform validate

.PHONY: dev
dev: ## Make develop backend.tf
	@envsubst '$$ENV' < backend.tf.template > backend.tf

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
