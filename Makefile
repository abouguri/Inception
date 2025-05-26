# Colors for better visualization
GREEN = \033[0;32m
YELLOW = \033[0;33m
RESET = \033[0m

# Project name
NAME = inception

# Docker Compose file
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

# Data directory
DATA_DIR = /home/$(USER)/data

# Targets
all: setup build up

setup:
	@echo "$(GREEN)Creating necessary directories...$(RESET)"
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb

build:
	@echo "$(GREEN)Building Docker images...$(RESET)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) build

up:
	@echo "$(GREEN)Starting containers...$(RESET)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "$(YELLOW)Stopping containers...$(RESET)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean: down
	@echo "$(YELLOW)Removing containers, networks, volumes, and images...$(RESET)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down -v --rmi all

fclean: clean
	@echo "$(YELLOW)Removing data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)/wordpress/*
	@sudo rm -rf $(DATA_DIR)/mariadb/*

re: fclean all

.PHONY: all setup build up down clean fclean re