-include .env

DOCKER_COMPOSE=docker-compose

local:
	$(DOCKER_COMPOSE) down
	ln -svf conf/docker-compose.device.yml docker-compose.override.yml
	$(DOCKER_COMPOSE) config
.PHONY: local

run_local:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) -f docker-compose.yml \
		-f conf/docker-compose.develop.yml \
		-f conf/docker-compose.device.yml \
		up
.PHONY: run_local

run:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) \
		-f docker-compose.yml \
		-f conf/docker-compose.device.yml \
		up
.PHONY: run

lint:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) -f docker-compose.yml \
		-f conf/docker-compose.lint.yml \
		run blinker
.PHONY: test)

build:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) build
.PHONY: build
