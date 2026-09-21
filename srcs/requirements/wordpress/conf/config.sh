#!/bin/bash
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp core download --allow-root
    wp config create --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306

    wp core install --allow-root \
                    --url="efoyer.42.fr" \
                    --title="Inception" \
                    --admin_user="${WP_ADMIN_USER}" \
                    --admin_password="${WP_ADMIN_PASSWORD}" \
                    --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
                "${WP_USER}" "${WP_USER_EMAIL}" \
                --user_pass="${WP_USER_PASSWORD}" \
                --role=author

    chown -R www-data:www-data /var/www/wordpress
fi

exec php-fpm8.2 -F