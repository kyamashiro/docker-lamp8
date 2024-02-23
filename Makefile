.PHONY: up build down remove bash mysql/bash

up:
	docker compose up -d

build:
	docker compose -f "compose.yml" up -d --build

down:
	docker compose stop

remove:
	$(MAKE) down
	docker compose rm

bash:
	docker exec -it --user 1000 php-apache bash

mysql/bash:
	docker exec -it mysql bash
