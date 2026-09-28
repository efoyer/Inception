
**USER_DOC.md**

This document provides end-users and administrators with the necessary information to understand, access, and manage the Inception infrastructure.

### 1. Services Provided by the Stack

The infrastructure deploys a complete network of isolated containers offering the following services:

-   **Secure Web Server (Nginx):** The main encrypted entry point (HTTPS on port 443) to access the websites.
    
-   **Website (WordPress):** The content management system powered by PHP-FPM.
    
-   **Database (MariaDB):** A secure relational storage system for WordPress data.
    
-   **In-Memory Cache (Redis):** An optimization service (Bonus) that caches database queries to speed up WordPress.
    
-   **FTP Server (vsftpd):** A file transfer service (Bonus) providing direct access to the WordPress directories on port 21.
    
-   **Static Website:** A showcase page (Bonus) served by its own lightweight Nginx server.
    
-   **Database Manager (Adminer):** A graphical web interface (Bonus) to easily explore and modify MariaDB.
    
-   **Administration Interface (Portainer):** A web dashboard (Bonus) to monitor and manage all Docker containers via port 9000.
    

### 2. Starting and Stopping the Project

The project is fully automated using a `Makefile` located at the root of the repository.

-   **To start the project:** Open a terminal at the root of the project and run `make all`. This will create the necessary local folders and launch the infrastructure in the background.
    
-   **To stop the project:** Run `make down`. This shuts down the containers safely without destroying your persistent data.
    

### 3. Accessing the Websites and Administration Panels

_Note: Your browser will likely display a security warning due to the self-signed SSL certificate. You must accept the risk to proceed._

-   **WordPress Website (Home):** `[https://efoyer.42.fr](https://efoyer.42.fr)`
    
-   **WordPress Administration:** `[https://efoyer.42.fr/wp-admin](https://efoyer.42.fr/wp-admin)`
    
-   **Static Page:** `[https://efoyer.42.fr/static/](https://efoyer.42.fr/static/)`
    
-   **Adminer Panel:** `[https://efoyer.42.fr/adminer/](https://efoyer.42.fr/adminer/)`
    
-   **Portainer Panel:** `[http://efoyer.42.fr/portainer/](http://efoyer.42.fr/portainer/)`
    
-   **FTP Access:** Connect using an FTP client to `efoyer.42.fr` on port 21.
    

### 4. Locating and Managing Credentials

All passwords and usernames are securely centralized in a hidden file named `.env` located inside the `srcs/` directory.

-   Edit the `srcs/.env` file with a text editor before the initial launch.
    
-   It contains the variables for the database (`SQL_USER`, `SQL_PASSWORD`, `SQL_ROOT_PASSWORD`), WordPress administrators (`WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`), and FTP access (`FTP_USR`, `FTP_PWD`).
    

### 5. Checking that Services are Running Correctly

**Checking container status:**

-   **Via Portainer:** Log in to `[http://efoyer.42.fr/portainer/](http://efoyer.42.fr/portainer/)` and navigate to the "Containers" tab to see the current state ("running", "stopped") of each service.
    
-   **Via Terminal:** At the root of the project, run `docker compose -f srcs/docker-compose.yml ps` to list the active processes.
    

**Testing the Database (MariaDB):**

You can verify that the database is operational and that data persists using two methods:

-   **Via the Graphical Interface (Adminer):**
    
    1.  Go to `[https://efoyer.42.fr/adminer/](https://efoyer.42.fr/adminer/)`.
        
    2.  Log in using **MySQL** as the system, **mariadb** as the server, your `.env` user (`efoyer`), your password, and the `wordpress` database.
        
    3.  Visually explore the created tables (e.g., `wp_users`).
        
-   **Via the Terminal:**
    
    1.  Connect to the MySQL engine inside the container: `docker exec -it mariadb mysql -u efoyer -p`
        
    2.  Enter your password when prompted.
        
    3.  Run `SHOW DATABASES;` to confirm the presence of the `wordpress` database.
