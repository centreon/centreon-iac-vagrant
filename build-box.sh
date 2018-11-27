#!/bin/sh
echo "Start Vagrant machine to build Box ..."
vagrant up
echo "Preparing module Ansible to Deploy a new installation of Centreon ..."
git clone --single-branch -b new_wrapper https://github.com/centreon/centreon-ansible
echo "Start installation of Centreon using Ansible ..."
cd centreon-ansible
ansible-playbook -i ../hosts.ansible ../deploy.yml
echo "Export image to Box format"
cd ..
vagrant package --output centreon.box