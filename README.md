
*This project has been created as part of the 42 curriculum by efoyer.*

## Description

The goal of the Inception project is to broaden your knowledge of system administration by using Docker to virtualize a multi-service infrastructure. You are required to deploy a complete LEMP-like stack (Linux, Nginx, MariaDB, PHP-FPM/WordPress) alongside several bonus features, ensuring each service runs in its own dedicated, isolated container.

### Design Choices & Sources

This project relies exclusively on Docker Compose to orchestrate the infrastructure. Every container is built from scratch using a `debian:bookworm` base image and custom Dockerfiles. Key design choices include:

-   **PID 1 Management:** Custom entrypoint scripts (`config.sh`, `script.sh`) are used to configure services at runtime before starting the main daemon processes in the foreground using `exec`.
    
-   **Data Persistence:** Persistent storage is achieved by mounting local host directories (`/home/efoyer/data/*`) directly into the MariaDB and WordPress containers.
    
-   **Bonus Services Integration:** The network includes a Redis cache layer for WordPress, an FTP server mapped to the web directory, Adminer for database management, and a static website, all sharing the same internal Docker network for secure communication.
    

### Technical Comparisons

-   **Virtual Machines vs Docker:** Virtual Machines virtualize the underlying hardware, running a complete guest Operating System for each instance. This requires significant CPU, memory, and storage overhead. Docker virtualizes the OS kernel, allowing containers to share the host system's kernel while remaining isolated. Containers are lightweight, start almost instantly, and consume far fewer resources than VMs.
    
-   **Secrets vs Environment Variables:** Environment variables are often stored in plain text within configuration files (like `.env`) and can be exposed via process lists, server logs, or `docker inspect`. Docker Secrets provide a secure, encrypted mechanism to inject sensitive data into containers. Secrets are mounted into an in-memory filesystem (usually `/run/secrets/`), ensuring they are never written to disk or exposed in environment variables.
    
-   **Docker Network vs Host Network:** A custom Docker network (like a bridge network) creates an isolated local network where containers can securely communicate with each other using DNS resolution (container names) without exposing their ports to the outside world. The Host network mode strips away this isolation, attaching the container directly to the host machine's networking stack. This exposes all container ports to the host interface and increases security risks.
    
-   **Docker Volumes vs Bind Mounts:** Docker Volumes are fully managed by Docker and stored within Docker's internal storage directory on the host. They are the preferred mechanism for persistent data because they are portable and isolated from the core host file system. Bind Mounts map a specific, absolute path on the host machine directly into the container. While useful for development, bind mounts tie the container directly to the host's specific directory structure and permissions.
    

## Instructions

### Prerequisites

-   Docker and Docker Compose plugin installed.
    
-   `make` utility installed.
    
-   Update your `/etc/hosts` file to resolve `efoyer.42.fr` to `127.0.0.1`.
    

### Execution

The project is entirely managed via the provided `Makefile` at the repository root.

1.  **Start the infrastructure:**
    
    Bash
    
    ```
    make all
    
    ```
    
    This command creates the necessary local data directories (`/home/efoyer/data/mariadb` and `/home/efoyer/data/wordpress`) and runs `docker compose up -d --build`.
    
2.  **Stop the containers:**
    
    Bash
    
    ```
    make down
    
    ```
    
3.  **Clean up containers and volumes:**
    
    Bash
    
    ```
    make clean
    
    ```
    
4.  **Full reset (Deep Clean):**
    
    Bash
    
    ```
    make fclean
    
    ```
    
    This stops everything, removes volumes, deletes the local persistent data in `/home/efoyer/data/`, and prunes the Docker system.
    

## Resources

-   [Docker Official Documentation](https://docs.docker.com/)
    
-   [Nginx Documentation](https://nginx.org/en/docs/)
    
-   [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
    
-   [WordPress Developer Resources & WP-CLI](https://developer.wordpress.org/)
    
-   **AI Usage:** AI was used to clarify certain technical aspects, resolve complex bugs, assist with specific configurations—particularly for add-ons where documentation for headless installation is scarce—and draft Markdown files.
