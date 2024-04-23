# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Configure shared folder
  config.vm.synced_folder "/Users/sintimmisa/Desktop/cloud_eng/altschool/exams/vagrant", "/vagrant" 
  config.vm.network "public_network", bridge: "en0: Wi-fi (AirPort)"
  # Configure master machine
  config.vm.define "ubuntuMaster" do |ubuntuMaster|
    ubuntuMaster.vm.box = "ubuntu/focal64"
    ubuntuMaster.vm.hostname = "ubuntuMaster"
    ubuntuMaster.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct:true
    ubuntuMaster.vm.network:private_network, ip: "192.168.33.10", type: "dhcp"

    # Set up memory and CPUs for master
    ubuntuMaster.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    # Provision master node to set up LAMP stack
    ubuntuMaster.vm.provision "shell", inline: <<-SHELL

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

    SHELL

  end

  # Configure slave machine (consider using Ansible for deployment on slave)
  config.vm.define "ubuntuSlave" do |ubuntuSlave|
    ubuntuSlave.vm.box = "ubuntu/focal64"
    ubuntuSlave.vm.hostname = "ubuntuSlave"
    ubuntuSlave.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct:true
    ubuntuSlave.vm.network:private_network, ip: "192.168.33.11" ,type: "dhcp"

    ubuntuSlave.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
  end


end
