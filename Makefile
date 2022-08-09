# See: https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html
SHELL := /bin/bash

CWD := $(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P)
VENV := $(CWD)/.venv
ENV := $(CWD)/.env

.PHONY: run
run: docker-compose.yml
	@ if [ ! -f .env ]; then cp .env.base .env; fi; 
	@ docker compose up -d && docker compose ps;

.PHONY: stop
stop: docker-compose.yml
	docker compose down

# Poetry

GET_POETRY_URL := https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py

.PHONY: install-poetry
install-poetry:
	curl -sSL $(GET_POETRY_URL) | python - && poetry --version

.PHONY: update-poetry
update-poetry:
	poetry self update $(version)

.PHONY: uninstall-poetry
uninstall-poetry:
	curl -sSL $(GET_POETRY_URL) | python - --uninstall

# Virtual environment

.PHONY: venv-activate
venv-activate:
	cd ./app && poetry shell && poetry env info

.PHONY: venv-deactivate
venv-deactivate:
	exit