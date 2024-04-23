
    #!/bin/bash

    # Update package repositories
    sudo apt update

    # Install dependencies
    sudo apt install -y apache2 mysql-server php libapache2-mod-php7.4 php-mysql git

    # Access Db configuration file 
    DB_NAME=$(awk '/^DB_NAME=/ {print $2}' database.cfg)
   
    # DB_URL=$(awk '/^DB_URL=/ {print $2}' database.cfg)

    # Clone PHP application (Replace with your actual URL)
    git clone https://github.com/laravel/laravel /var/www/html/laravel

    # Configure Apache
    sudo a2enmod php7.4
    sudo systemctl restart apache2

    # Grant ownership and permissions for Apache
    sudo chown -R www-data:www-data /var/www/html/laravel
    sudo chmod -R 755 /var/www/html/laravel

    # MySQL configuration (Create a dedicated user with secure password)
    # Replace "your_username" and "your_password" with strong credentials
    sudo mysql -e "CREATE DATABASE $DB_NAME;"
    sudo mysql -e "CREATE USER 'sysAdmin' @ 'localhost' IDENTIFIED BY 'h@ppy2024!';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'sysAdmin'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES:"