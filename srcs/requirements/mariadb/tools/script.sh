#!/bin/bash

# Démarrer le service pour pouvoir le configurer
service mariadb start

# Création de la base et de l'utilisateur (autorisé depuis n'importe quelle IP avec '%')
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Sécurisation de l'utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Extinction propre du service configuré (correction de la faute de frappe)
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Lancement du démon au premier plan
exec mysqld_safe