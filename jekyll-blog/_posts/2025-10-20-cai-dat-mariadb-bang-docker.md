---
layout: post
title: "Cài đặt MariaDB bằng Docker"
date: 2025-10-20 10:00:00 +0700
categories: concept-base technical database SQL MariaDB
tags: ["mysql", "docker", "database", "sql"]
source_path: "Evergreen/concept-base/technical/database/SQL/MariaDB/Cài đặt MariaDB bằng Docker.md"
---
To install MariaDB using Docker and configure the port, username, and password, you can follow these steps:

1. **Pull the MariaDB Docker image:**
    
    First, pull the official MariaDB image from Docker Hub:
    
    Sao chép mã
    
    `docker pull mariadb`
    
2. **Run the MariaDB container:**
    
    Now, you can run the MariaDB container with custom settings for the port, username, and password. Here's the command:
    
    bash
    
    `docker run --name mariadb-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_USER=myuser -e MYSQL_PASSWORD=mypassword -p 3308:3306 -d mariadb`
    
    **Explanation of the options:**
    
    - `--name mariadb-container`: This gives your container a name (you can choose any name you prefer).
    - `-e MYSQL_ROOT_PASSWORD=my-secret-pw`: This sets the root password for MariaDB (you can replace `my-secret-pw` with your own password).
    - `-e MYSQL_USER=myuser`: This sets a custom username (replace `myuser` with your preferred username).
    - `-e MYSQL_PASSWORD=mypassword`: This sets the password for the custom username (replace `mypassword` with your preferred password).
    - `-p 3308:3306`: This binds port 3306 inside the container to port 3308 on your host machine, so you can access the MariaDB instance using port 3308.
    - `-d`: This runs the container in detached mode (in the background).
3. **Verify the container is running:**
    
    To check if your container is running, use the following command:
    
    bash
    
    `docker ps`
    
    You should see `mariadb-container` listed along with the port mapping `0.0.0.0:3308->3306/tcp`.
    
4. **Access the MariaDB instance:**
    
    You can access the MariaDB instance inside the container using the following command:
    
    bash
    
    `docker exec -it mariadb-container mysql -u myuser -p`
    
    After entering your password, you will be connected to the MariaDB instance. You can then start running SQL commands.
    


This will set up MariaDB on port `3308` with the username `myuser` and password `mypassword`.


---
## Liên quan

https://chatgpt.com/share/67852f8e-2780-8013-8105-ce018d1377fc

#docker #database #sql #mariaDB

---
*Nguồn: Evergreen/concept-base/technical/database/SQL/MariaDB/Cài đặt MariaDB bằng Docker.md*