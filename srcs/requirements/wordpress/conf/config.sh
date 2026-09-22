#!/bin/bash
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp core download --allow-root
    sleep 15
    wp config create --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306

    wp core install --allow-root \
                    --url="https://efoyer.42.fr" \
                    --title="Inception" \
                    --admin_user="${WP_ADMIN_USER}" \
                    --admin_password="${WP_ADMIN_PASSWORD}" \
                    --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
                "${WP_USER}" "${WP_USER_EMAIL}" \
                --user_pass="${WP_USER_PASSWORD}" \
                --role=author
    
    # Configuration des variables Redis pour WordPress
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT efoyer.42.fr --allow-root
    wp config set WP_REDIS_CLIENT phpredis --allow-root

    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

    chown -R www-data:www-data /var/www/wordpress
fi

exec php-fpm8.2 -F