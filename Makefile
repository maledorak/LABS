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

include .env
export $(shell sed 's/=.*//' .env)


help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

first-install: ## Installation on new system
	sudo apt-get install python3-pip
	sudo pip3 install pipenv
	pipenv install
	#mv ~/Downloads/id_rsa ~/.ssh
	#sudo chmod 0600 ~/.ssh/id_rsa
	#ssh-add ~/.ssh/id_rsa

install-submodules: ## Install submodules
	git submodule update --init --recursive

install: ## Set git submodules and Install pipenv apps.
	git submodule update --init --recursive
	pipenv install

dots-arch: ## Set dotfiles symlinks in arch.
	@echo "===== Public dotfiles arch setup ====="
	dotbot -c ${ARCH_DOTBOT_CONF}
	$(MAKE) _dots-private target="dots-arch"

dots-kubuntu: ## Set dotfiles symlinks in kubuntu.
	@echo "===== Public dotfiles kubuntu setup ====="
	dotbot -c ${KUBUNTU_DOTBOT_CONF}
	$(MAKE) _dots-private target="dots-kubuntu"

dots-macos: ## Set dotfiles symlinks in macos.
	@echo "===== Public dotfiles MacOs setup ====="
	dotbot -c ${MACOS_DOTBOT_CONF}
	$(MAKE) _dots-private target="dots-macos"

_dots-private:
	# use: $(MAKE) dots.private target="dots.some"
	# Check is private dir exists and run private Makefile
ifneq (,$(wildcard ./private/Makefile))
	$(MAKE) -C private $(target)
endif


apps-configure: ## Configure arch localhost.
	$(MAKE) -C apps configure

apps-tags: ## Configure arch localhost only with passed 'tags' ex. [make apps-tags tags="tag1,tag2"]
	$(MAKE) -C apps tags $(tags)

apps-show-tags: ## Show tags used in ansible
	$(MAKE) -C apps show-tags
