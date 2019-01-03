help:
	@echo "install - Init submodules and install las requirements."
	@echo "configure-arch - Configure arch localhost."
	@echo "run-tags - Configure arch localhost only with passed 'tags'."

install:
	git submodule init
	git submodule update
	pipenv install

configure-arch:
	ansible-playbook -K -vv configure_arch.yml

run-tags:
	# use: make run-tags tags="tag1,tag2"
	ansible-playbook -K -vv configure_arch.yml --tags "${tags}"
