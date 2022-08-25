# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # image de base
  config.vm.box = "debian/buster64"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./files", "/vagrant", create: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = ENV['NAME'] || "l2_box"

    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  config.vm.provision "shell", path: "files/install.sh"
end
