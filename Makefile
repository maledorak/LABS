help:
	@echo "install - Init submodules and install las requirements."
	@echo "arch-config - Configure arch localhost."

install:
	git submodule init
	git submodule update
	pipenv install

configure-arch:
	ansible-playbook -K -vv install_apps.yml