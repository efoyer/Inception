NAME = inception
COMPOSE = srcs/docker-compose.yml
DATA_PATH = /home/efoyer/data

all:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/portainer
	@docker compose -f $(COMPOSE) up -d --build

down:
	@docker compose -f $(COMPOSE) down

clean: down
	@docker compose -f $(COMPOSE) down -v

fclean: clean
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/portainer/*
	@docker system prune -af

re: fclean all

.PHONY: all down clean fclean re