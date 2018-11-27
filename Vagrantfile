# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
      mkdir /root/.ssh
      echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      chmod 0700 /root/.ssh
      chmod -R 0600 /root/.ssh/*
      echo "Installation of VirtualBox Guest"
      yum upgrade -y
      yum install -y epel-release wget
      yum install -y dkms
      yum groupinstall -y "Development Tools"
      yum install -y kernel-devel
      wget http://download.virtualbox.org/virtualbox/5.2.22/VBoxGuestAdditions_5.2.22.iso
      mount -o loop VBoxGuestAdditions_5.2.22.iso /mnt
      sh /mnt/VBoxLinuxAdditions.run
      umount /mnt
      rm -rf VBoxGuestAdditions_5.2.22.iso
      yum remove -y kernel-devel dkms
      yum groupremove -y "Development Tools"
    SHELL
  end
end
