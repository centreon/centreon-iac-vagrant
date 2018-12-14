#!/bin/sh
echo "Start Vagrant machine to build Box ..."
vagrant up
echo "Preparing module Ansible to Deploy a new installation of Centreon ..."
git clone --single-branch -b master https://github.com/centreon/centreon-ansible
echo "Start installation of Centreon using Ansible ..."
cd centreon-ansible
ansible-playbook -i ../hosts.ansible ../deploy.yml
echo "Cleanup image ..."
vagrant ssh -c "sudo yum clean -y all && sudo rm -rf /var/cache/yum"
echo "Export image to Box format"
cd ..
vagrant package --output centreon.box
