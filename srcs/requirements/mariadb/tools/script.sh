#!/bin/bash

service mariadb start

# Creation de la base et de l'utilisateur
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Securisation de l'utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Extinction propre du service configure
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Lancement du demon au premier plan
exec mysqld_safe