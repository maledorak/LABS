#!make
include .env
export $(shell sed 's/=.*//' .env)

help:
	@echo "====================     Help     ===================="
	@echo "install ................ Set git submodules and Install pipenv apps."
	@echo "dotfiles.configure ............... Set dotfiles symlinks."
	@echo "apps.configure ......... Configure arch localhost."
	@echo "apps.tags .............. Configure arch localhost only with passed 'tags'."

install:
	git submodule update --init --recursive
	pipenv install

dots.arch:
	@echo "===== Public dotfiles arch setup ====="
	dotbot -c ${PUBLIC_DOTBOT_CONF}
# Check is private dir exists and run private Makefile
ifneq (,$(wildcard ./private/Makefile))
	$(MAKE) -C private configure
endif

dots.kubuntu:
	@echo "===== Public dotfiles kubuntu setup ====="
	dotbot -c ${KUBUNTU_PUBLIC_DOTBOT_CONF}

apps.configure:
	ansible-playbook -K -vv apps/configure_arch.yml

apps.tags:
	# use: make run-tags tags="tag1,tag2"
	ansible-playbook -K -vv apps/configure_arch.yml --tags "${tags}"
