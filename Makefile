# TO BE SET ACCORDINGLY TO YOUR ENVIRONMENT IN THE MAKE FILE
VENV_BIN ?= .build/venv/Scripts

PYTHON_EXE ?= python3

SUB_PROJECT = crdppf_core

# Templates
VARS_FILES += $(SUB_PROJECT)/CONST_vars.yaml

export INSTANCE_ID

C2C_TEMPLATE_CMD = $(VENV_BIN)/c2c-template --vars $(VARS_FILE)

# Disabling Make built-in rules to speed up execution time
.SUFFIXES:

.PHONY: help
help:
	@echo  "Usage: make <target>"
	@echo
	@echo  "Main targets:"
	@echo
	@echo  "- build			Build and configure the project"
	@echo  "- update-git-submodules	Update and clean the Git submodules"
	@echo  "- clean			Remove generated files"
	@echo  "- cleanall		Remove all the build artefacts"
ifdef UTILITY_HELP
	@echo $(UTILITY_HELP)
endif
	@echo
	@echo  "Secondary targets:"
	@echo
	@echo  "- template-clean	Clean the template file"
	@echo  "- template-generate	Generate the template file"
ifdef SECONDARY_HELP
	@echo $(SECONDARY_HELP)
endif
	@echo

.PHONY: build
build: template-generate docker-build-config docker-build-geoportal

# Docker

DOCKER_BASE ?= sitj/crdppf
export DOCKER_BASE
DOCKER_TAG ?= latest
export DOCKER_TAG

GIT_HASH ?= $(shell git rev-parse HEAD)

.PHONY: docker-build-config
docker-build-config:
	docker build --file=Dockerfile_config --tag=$(DOCKER_BASE)-config:$(DOCKER_TAG) .

.PHONY: docker-build-geoportal
docker-build-geoportal:
	docker build --file=Dockerfile_geoportal --tag=$(DOCKER_BASE)-geoportal:$(DOCKER_TAG) --build-arg=GIT_HASH=$(GIT_HASH) .


.PHONY: clean
clean: template-clean
	rm -f .build/*.timestamp

.PHONY: checks
checks: flake8

.PHONY: flake8
flake8: .build/requirements.timestamp
	$(VENV_BIN)/flake8 crdppfportal

# Templates
.PHONY: template-clean
template-clean:
	rm -f .env

.PHONY: template-generate
template-generate: .env

.env: .env.mako .build/requirements.timestamp $(VARS_FILES)
	$(ENVIRONMENT_VARS) $(C2C_TEMPLATE_CMD) --engine mako --files $<

.PHONY: update-git-submodules
update-git-submodules:
	cd $(SUB_PROJECT) && git submodule sync
	cd $(SUB_PROJECT) && git submodule update --init

.build/venv.timestamp-noclean:
	mkdir -p $(dir $@)
	$(PYTHON_EXE) -m venv --system-site-packages .build/venv
	$(VENV_BIN)/$(PYTHON_EXE) -m pip install --upgrade pip
	touch $@

.build/requirements.timestamp: requirements_dev.txt .build/venv.timestamp-noclean
	$(VENV_BIN)/$(PYTHON_EXE) -m pip install --requirement=requirements_dev.txt
	touch $@
