#!make

help:
	@echo "====================     Help     ===================="
	@echo "configure ......... Configure arch localhost."
	@echo "tags .............. Configure arch localhost only with passed 'tags'."

configure:
	ansible-playbook -K -vv apps/configure_arch.yml

tags:
	# use: make run-tags tags="tag1,tag2"
	ansible-playbook -K -vv configure_arch.yml --tags "${tags}"
