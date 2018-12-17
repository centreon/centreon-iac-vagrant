# Vagrant Cloud Centreon

## Usage

You can use two methods to use the Centreon Box:

**Method 1**:

Create a file with name `Vagrantfile` with this content:

```ruby
# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "lgcosta/centreon"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
```

**Method 2**:

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
- Ansible
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
