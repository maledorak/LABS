#!make
include .env
export $(shell sed 's/=.*//' .env)

help:
	@echo "====================     Help     ===================="
	@echo "install ................ Set git submodules and Install pipenv apps."
	@echo "dots.arch ...............Set dotfiles symlinks in arch."
	@echo "dots.kubuntu ............Set dotfiles symlinks in kubuntu."
	@echo "dots.macos ..............Set dotfiles symlinks in macos."
	@echo "apps.configure ......... Configure arch localhost."
	@echo "apps.tags .............. Configure arch localhost only with passed 'tags'."

install:
	git submodule update --init --recursive
	pipenv install

dots.arch:
	@echo "===== Public dotfiles arch setup ====="
	dotbot -c ${ARCH_DOTBOT_CONF}
	$(MAKE) _dots.private target="dots.arch"

dots.kubuntu:
	@echo "===== Public dotfiles kubuntu setup ====="
	dotbot -c ${KUBUNTU_DOTBOT_CONF}
	$(MAKE) _dots.private target="dots.kubuntu"

dots.macos:
	@echo "===== Public dotfiles MacOs setup ====="
	dotbot -c ${MACOS_DOTBOT_CONF}
	$(MAKE) _dots.private target="dots.macos"

_dots.private:
	# use: $(MAKE) dots.private target="dots.some"
	# Check is private dir exists and run private Makefile
ifneq (,$(wildcard ./private/Makefile))
	$(MAKE) -C private $(target)
endif


apps.configure:
	$(MAKE) -C apps configure

apps.tags:
	# use: make run-tags tags="tag1,tag2"
	$(MAKE) -C apps $(tags)
