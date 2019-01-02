#!make
include .env
export $(shell sed 's/=.*//' .env)

help:
	@echo "dotfiles-install - Set symlinks."
	@echo "pipenv-install - Install apps."

dotfiles-install:
	dotbot -c ${DOTBOT_CONF}

pipenv-install:
	pipenv install
