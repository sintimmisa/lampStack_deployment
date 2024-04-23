
    #!/bin/bash

    # check if database exist then define source
    if [ -f "database.cfg"]; then
         source database.cfg

    fi

    # DB configuration
    DB_NAME =${DB_NAME:-lampStack_db}
    DB_USER = ${DB_USER:-sysAdmin}
    DB_PASSWORD = ${DB_PASSWORD:-h@ppy2024}
    
    LAMPSTACK_URL=${LAMPSTACK_URL:-https://github.com/laravel/laravel}

    # Update package repositories
    sudo apt update || exit 1

    #check for exixtance of command (sudo, git and mysql)
    if ! command_exists "sudo" || ! command_exists "git" || ! command_exists "mysql": then
       echo "Error: Required commands(sudo, git, and mysql) missing. Please Install and proceed" > &2
       exit 1
    fi

    # Install dependencies
    sudo apt install -y apache2 mysql-server php libapache2-mod-php7.4 php-mysql git || exit 1

    # Access Db configuration file 
    #DB_NAME=$(awk '/^DB_NAME=/ {print $2}' database.cfg)
   
    # DB_URL=$(awk '/^DB_URL=/ {print $2}' database.cfg)



    # Configure Apache
    sudo a2enmod php7.4 || exit 1
    sudo systemctl restart apache2 || exit 1

    # Grant ownership and permissions for Apache
    sudo chown -R www-data:www-data /var/www/html || exit 1
    sudo chmod -R 755 /var/www/html  || exit 1

    # MySQL configuration (Create a dedicated user with secure password)
    # Replace "your_username" and "your_password" with strong credentials
    sudo mysql -e "CREATE DATABASE $DB_NAME;"
    sudo mysql -e "CREATE USER '$DB_USER'@ 'localhost' IDENTIFIED BY '$DB_PASSWORD';" || exit 1
    sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';" || exit 1
    sudo mysql -e "FLUSH PRIVILEGES:" || exit 1


    # Clone PHP application (Replace with your actual URL)
    git clone $LAMPSTACK_URL /var/www/html/app || exit 1

    # Display success message 

    echo "App Deployed Sucessfully on ubuntuMaster Server..."