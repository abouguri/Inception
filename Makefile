NAME = inception

all: prepare build up

prepare:
	@echo "🔧 Creating project-local data directories..."
	@mkdir -p /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	@echo "🔒 Setting correct permissions for containers..."
	@chown -R 999 /home/$(USER)/data/mariadb 2>/dev/null || true  # MariaDB UID
	@chown -R 82 /home/$(USER)/data/wordpress 2>/dev/null || true # WordPress UID
	@echo "🌐 Adding host entry (no sudo required!)"
	@echo "127.0.0.1 $(USER).42.fr" | tee -a ./hosts.tmp
	@sudo cp ./hosts.tmp /etc/hosts && rm -f ./hosts.tmp

build:
	@docker compose -f srcs/docker-compose.yml build

up:
	@docker compose -f srcs/docker-compose.yml up -d
	@echo "\n✅ Inception stack running! Test with:"
	@echo "   curl -k https://$(USER).42.fr"
	@echo "   curl -k http://localhost:8080   # Static website test"

down:
	@docker compose -f srcs/docker-compose.yml down

clean: down
	@docker system prune -a --force
	@docker volume prune -f
	@echo "🧹 Removing project data (Inception-compliant)"
	@sudo chown -R $(USER):$(USER) /home/$(USER)/data 2>/dev/null || true
	@sudo rm -rf /home/$(USER)/data 2>/dev/null || true

fclean: clean
	@echo "🧹 Removing named volumes"
	@docker compose -f srcs/docker-compose.yml down -v 2>/dev/null || true
	@docker volume rm srcs_mariadb_data srcs_wordpress_data 2>/dev/null || true
	@echo "🧹 Removing host entry"
	@sudo sed -i.bak '/$(USER).42.fr/d' /etc/hosts 2>/dev/null || true
	@sudo rm -f /etc/hosts.bak 2>/dev/null || true

re: fclean all

.PHONY: all prepare build up down clean fclean re