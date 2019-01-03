#!make
include .env
export $(shell sed 's/=.*//' .env)

help:
	@echo "====================     Help     ===================="
	@echo "install ................ Set git submodules and Install pipenv apps."
	@echo "dotfiles.configure ..... Set symlinks."
	@echo "apps.configure ......... Configure arch localhost."
	@echo "apps.tags .............. Configure arch localhost only with passed 'tags'."

install:
	git submodule init
	git submodule update
	pipenv install

dotfiles.configure:
	dotbot -c ${DOTBOT_CONF}

apps.configure:
	ansible-playbook -K -vv apps/configure_arch.yml

apps.tags:
	# use: make run-tags tags="tag1,tag2"
	ansible-playbook -K -vv apps/configure_arch.yml --tags "${tags}"
