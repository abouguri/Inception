NAME = inception

all: prepare build up

prepare:
	@echo "🔧 Creating project-local data directories..."
	@mkdir -p ./data/{mariadb,wordpress}
	@echo "🔒 Setting correct permissions for containers..."
	@chown -R 999 ./data/mariadb 2>/dev/null || true  # MariaDB UID
	@chown -R 82 ./data/wordpress 2>/dev/null || true # WordPress UID
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
	@rm -rf ./data

fclean: clean
	@echo "🧹 Removing host entry"
	@sed -i.bak '/$(USER).42.fr/d' ./hosts.tmp 2>/dev/null || true
	@sudo cp ./hosts.tmp /etc/hosts 2>/dev/null || true
	@rm -f ./hosts.tmp ./hosts.tmp.bak 2>/dev/null || true

re: fclean all

.PHONY: all prepare build up down clean fclean re