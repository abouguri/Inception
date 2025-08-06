NAME = inception

all: prepare build up

prepare:
	@echo "🔧 Creating project-local data directories..."
	@mkdir -p /home/abouguri/Inception/data/mariadb /home/abouguri/Inception/data/wordpress
	@echo "🔒 Setting correct permissions for containers..."
	@chown -R 999 /home/abouguri/Inception/data/mariadb 2>/dev/null || true  # MariaDB UID
	@chown -R 82 /home/abouguri/Inception/data/wordpress 2>/dev/null || true # WordPress UID
	@echo "🌐 Adding host entry (no sudo required!)"
	@echo "127.0.0.1 $(USER).42.fr" | tee -a ./hosts.tmp
	@sudo cp ./hosts.tmp /etc/hosts && rm -f ./hosts.tmp

build:
	@docker compose -f srcs/docker-compose.yml build

up:
	@docker compose -f srcs/docker-compose.yml up -d
	@echo "\n✅ Inception stack running! Test with:"
	@echo "   curl -k https://$(USER).42.fr"

down:
	@docker compose -f srcs/docker-compose.yml down

clean: down
	@docker system prune -a --force
	@docker volume prune -f
	@echo "🧹 Removing project data (Inception-compliant)"
	@sudo rm -rf /home/abouguri/Inception/data

fclean: clean
	@echo "🧹 Removing host entry"
	@sudo sed -i.bak '/$(USER).42.fr/d' /etc/hosts 2>/dev/null || true
	@sudo rm -f /etc/hosts.bak 2>/dev/null || true

re: fclean all

.PHONY: all prepare build up down clean fclean re