AWS_PROFILE ?= $(shell echo "$$USER.$$(basename $$(dirname $$(pwd)))")

.PHONY: apply
apply:
	AWS_PROFILE=${AWS_PROFILE} terraform apply

.PHONY: force_apply
force_apply:
	AWS_PROFILE=${AWS_PROFILE} echo -e "yes\n" | terraform apply

.PHONY: init
init:
	AWS_PROFILE=${AWS_PROFILE} terraform init

.PHONY: plan
plan: init
	AWS_PROFILE=${AWS_PROFILE} terraform plan | landscape

terraform:
	@echo $(shell which terraform)
