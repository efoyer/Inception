
### 1. Setting up the Environment
*   **System Prerequisites:** Docker, the Docker Compose plugin, and `make` must be installed on the host machine.
*   **Local DNS Resolution:** The project domain must point to localhost. Edit the host machine's `/etc/hosts` file to include the line `127.0.0.1 efoyer.42.fr`.
*   **Secrets Management:** A valid `.env` file must be created manually in the `srcs/` directory before building the project. This file is intentionally ignored by Git (`.gitignore`) to prevent credential leaks. 

Create the `srcs/.env` file and paste the following template, adjusting the values as needed:

```env
# Database Credentials
SQL_DATABASE=wordpress
SQL_USER=efoyer
SQL_PASSWORD=your_db_password
SQL_ROOT_PASSWORD=your_root_password

# WordPress Administrator
WP_ADMIN_USER=master-chief
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=admin@42.fr

# WordPress Standard User
WP_USER=WP_USER
WP_USER_PASSWORD=your_user_password
WP_USER_EMAIL=user@42.fr

# Bonus: FTP Server
FTP_USR=efoyer
FTP_PWD=your_ftp_password

# Bonus: KasmVNC / Desktop
KSM_USR=kasm_user
KSM_PWD=your_kasm_password
```

### 2. Building and Launching

Deployment is orchestrated by the `Makefile` located at the root.

-   **Full Initialization (`make all`):** Creates the data persistence directories on the host machine (`/home/efoyer/data/mariadb`, `/home/efoyer/data/wordpress`, `/home/efoyer/data/portainer`). It then executes `docker compose -f srcs/docker-compose.yml up -d --build` to compile the images from their respective `Dockerfiles` and start the infrastructure.
    
-   **Deep Clean (`make fclean`):** Destroys containers and Docker virtual volumes, physically deletes the host data in `/home/efoyer/data/` using `sudo rm -rf`, and purges the Docker system of all images using `docker system prune -af`.
    

### 3. Relevant Commands for Management

-   **View container logs:** `docker compose -f srcs/docker-compose.yml logs -f <service_name>`
    
-   **Enter a running container:** `docker exec -it <container_name> bash`
    
-   **Rebuild a single service:** `docker compose -f srcs/docker-compose.yml up -d --build <service_name>`
    
-   **Inspect a virtual volume:** `docker volume inspect <volume_name>`
    

### 4. Data Persistence Architecture

The infrastructure uses Docker's `volumes` feature configured with the `local` driver to ensure data is saved safely.

-   The volumes are bind-mounted (using the `device` option) to strict physical directories on the host.
    
-   **Database:** The `mariadb` volume maps the internal `/var/lib/mysql` folder to the host directory `/home/efoyer/data/mariadb`.
    
-   **Website Files:** The `wordpress` volume maps `/var/www/wordpress` and `/var/www/html` to `/home/efoyer/data/wordpress`. It is shared between Nginx, WordPress, Redis, and the FTP server.
    
-   **Portainer:** The `portainer_data` volume stores its configuration in `/home/efoyer/data/portainer` and interacts with Docker via the mounted socket `/var/run/docker.sock`.
