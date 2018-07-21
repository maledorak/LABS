help:
	@echo "install - Init submodules and install las requirements."
	@echo "configure-arch - Configure arch localhost."

install:
	git submodule init
	git submodule update
	pipenv install

configure-arch:
	ansible-playbook -K -vv install_apps.yml