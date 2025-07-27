NAME = inception

all: prepare build up

prepare:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@echo "127.0.0.1 $(USER).42.fr" | sudo tee -a /etc/hosts

build:
	@docker compose -f srcs/docker-compose.yml build

up:
	@docker compose -f srcs/docker-compose.yml up -d

down:
	@docker compose -f srcs/docker-compose.yml down

clean: down
	@docker system prune -a --force
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf /home/$(USER)/data

fclean: clean
	@sudo sed -i '/$(USER).42.fr/d' /etc/hosts

re: fclean all

.PHONY: all prepare build up down clean fclean re