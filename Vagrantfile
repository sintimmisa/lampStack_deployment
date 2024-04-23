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

  #Grant permission for script
  #ubuntuMaster.vm.provision "shell", inline:<<-SHELL

    ###chmod +x  ./script/script.sh
  ##SHELL

    # Provision master node to set up LAMP stack
   # ubuntuMaster.vm.provision "shell", inline: <<-SHELL

    # Load Bash script file from script folder
   #   sh "./script/script.sh

   # SHELL

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
