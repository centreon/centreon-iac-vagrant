# Vagrant Cloud Centreon

Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Usage](#usage)
  - [Method 1](#method-1)
  - [Method 2](#method-2)
- [Additional information](#additional-information)
- [Building your own Box](#building-your-own-box)
  - [What will you need](#what-will-you-need)
- [Screencasts](#screencasts)
- [License](LICENSE)

## Overview

The Vagrant gives us an opportunity to develop and test the applications before we can put them in production and to meet this demand, here we have a setbox with an image ready and instructions to create your own box with the **Centreon**.

The idea is that you can experience a monitoring environment with **Centreon** and develop your ideas with this tool. Implementing this Vagrant with Centreon will give you a complete database environment and daemons ready for monitoring.

![centreon-screenshot](https://www.diigo.com/file/image/paesrbpzescbabrpdzdqcrqeps/vagrant-screen.jpg)

## Requirements

You will need the Vagrant tool to implement the **Centreon** box, we recommend that you use the latest version available on the project website, [see here the available distributions](https://www.vagrantup.com/downloads.html)

Currently the *Centreon* box is available for VirtualBox virtualization provider, you can use the version available in the repository of your Linux distribution or use a version available for [Windows or Mac](https://www.virtualbox.org/wiki/Downloads)

## Usage

You can use two methods to use the Centreon Box:

### Method 1

Create a file with name `Vagrantfile` with this content:

```ruby
# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "lgcosta/centreon"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
```

### Method 2

Use this command to create a default `Vagrantfile`:

```bash
vagrant init lgcosta/centreon
```

To initialize the box, use this command:

```bash
vagrant up
```

## Additional information

Default credentials to webgui interface:

```yaml
Username: admin
Password: centreon
```

You need mapped a port to access the webgui, for this, add these line in `Vagrantfile`

```ruby
config.vm.network "forwarded_port", guest: 80, host: 8080
```

reload config using command `vagrant reload` and access in your browser the address: `http://localhost:8080`

If you want to add your ssh key in the box, add the following lines in the file `Vagrantfile`:

```ruby
config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
    SHELL
end
```

## Building your own Box

### What will you need

- Vagrant
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Git access to repository [centreon-ansible](https://github.com/centreon/centreon-ansible)

Pull this repository:

```bash
git pull https://github.com/centreon/centreon-iac-vagrant
cd centreon-iac-vagrant
```

For build, you will only need to run the box building automation script:

```bash
sh build-box.sh
```

A new file was created: `centreon.box`

To use with Vagrant, add you box with command:

```bash
vagrant box add centreon.box
```

Done ! Now you can use the box with Vagrant, example:

```bash
vagrant init centreon
```

## Screencast

Building own box:
