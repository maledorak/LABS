.PHONY: help
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

print("{ln}{sp}HELP{sp}{ln}".format(ln=24*"=", sp=5*" "))
for line in sys.stdin:
	category_match = re.match(r'^### (.*)$$', line)
	target_match = re.match(r'^([a-zA-Z0-9_-]+):.*?## (.*)$$', line)
	if category_match:
		category, = category_match.groups()
		print("\n{}:".format(category))
	if target_match:
		target, help = target_match.groups()
		print("  {:26} {}".format(target, help))
endef
export PRINT_HELP_PYSCRIPT

include .env
export $(shell sed 's/=.*//' .env)
export PATH := ${NEW_PATH}

.PHONY: help
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.PHONY: _venv
_venv: ./.venv/bin/activate
	# venv in makefile based on: https://stackoverflow.com/a/46188210
	@echo "Dotbot is in" `which dotbot`
	@echo "Ansible is in" `which ansible`

### Utils commands
.PHONY: venv-reinstall
venv-reinstall: ## Reinstall LABS Python virtualenv - Use when it's broken
	sudo chown -R ${USER}:${USER} .venv
	@echo "Remove old .venv"
	rm -rf .venv
	@echo "Install venv with python:" `which python`
	python -m virtualenv .venv
	@echo "Install git submodule"
	git submodule update --init --recursive
	@echo "Install pip applications"
	.venv/bin/python -m pip install -r requirements.txt

.PHONY: fetch
fetch: ## Fetch LABS new commits
	@echo "##### Fetch private LABS #####"
	cd private && git fetch --all
	@echo "##### Fetch public LABS #####"
	git fetch --all

.PHONY: first-install
first-install: ## Installation on new system
	sudo apt-get install python3-pip
	sudo pip3 install pipenv
	pipenv install
	#mv ~/Downloads/id_rsa ~/.ssh
	#sudo chmod 0600 ~/.ssh/id_rsa
	#ssh-add ~/.ssh/id_rsa

### Dotfiles configuration
.PHONY: dots-arch
dots-arch: _venv ## Set dotfiles symlinks in arch.
	@echo "===== Public dotfiles arch setup ====="
	dotbot -c ${ARCH_DOTBOT_CONF}
	$(MAKE) _dots-private target="dots-arch"

.PHONY: dots-macos
dots-macos: _venv ## Set dotfiles symlinks in macos.
	@echo "===== Public dotfiles MacOs setup ====="
	dotbot -c ${MACOS_DOTBOT_CONF}
	$(MAKE) _dots-private target="dots-macos"

.PHONY: _dots-private
_dots-private: _venv
	# use: $(MAKE) dots.private target="dots.some"
	# Check is private dir exists and run private Makefile
ifneq (,$(wildcard ./private/Makefile))
	$(MAKE) -C private $(target)
endif

### Applications configuration
.PHONY: apps-configure-arch
apps-configure-arch: _venv ## Configure arch localhost.
	$(MAKE) -C apps configure-arch

.PHONY: apps-tags
apps-tags: _venv ## Configure arch localhost only with passed 'tags' ex. [make apps-tags tags="tag1,tag2"]
	$(MAKE) -C apps tags $(tags)

.PHONY: apps-show-tags
apps-show-tags:	_venv ## Show tags used in ansible
	$(MAKE) -C apps show-tags
