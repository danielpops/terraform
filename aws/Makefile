AWS_PROFILE:=dpopes.acct2
plan: init
	AWS_PROFILE=${AWS_PROFILE} terraform plan | landscape

init:
	AWS_PROFILE=${AWS_PROFILE} terraform init

apply:
	AWS_PROFILE=${AWS_PROFILE} terraform apply

force_apply:
	AWS_PROFILE=${AWS_PROFILE} echo -e "yes\n" | terraform apply

terraform:
	@echo $(shell which terraform)
