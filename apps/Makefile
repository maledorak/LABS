.PHONY: help
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

print("{ln}{sp}HELP{sp}{ln}".format(ln=25*"=", sp=5*" "))
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print(" - {:26} {}".format(target, help))
endef
export PRINT_HELP_PYSCRIPT

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

configure: ## Configure arch localhost.
	ansible-playbook -K -vv apps/configure_arch.yml

tags: ## Configure arch localhost only with passed 'tags' ex. [make apps-tags tags="tag1,tag2"]
	# use: make run-tags tags="tag1,tag2"
	ansible-playbook -K -vv configure_arch.yml --tags "$(tags)"

show-tags: ## Show tags used in ansible
	ansible-playbook --list-tags configure_arch.yml

