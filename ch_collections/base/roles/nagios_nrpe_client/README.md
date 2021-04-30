nagios_nrpe_client
=========

A role to install and configure the Nagios NRPE client and plugins.


Requirements
------------

Requires a functional package manager setup, with Redhat/Centos releases configured with the EPEL mirrors.


Role Variables
--------------

Most usages of this role will require the following variables:

```
#Configure self-registration settings so the instance can automatically register with Nagios
auto_register_client: true
nagios_host: nagios.db.hostname
server_template_name: "linux-server"

#Configure the hosts that are allowed to connect to the nrpre daemon. Hosts or CIDRs are supported
nrpe_server_allowed_hosts:
  - 127.0.0.1

#List of plugin packages to install, defaults to nagios-plugins-all
nrpe_plugin_packages:
  - nagios-plugins-ntp
  - nagios-plugins-dig
  - nagios-plugins-load

#Configure nrpe plugin commands
nrpe_command:
  check_disk_all:
    script: check_disk
    option: -w 80 -c 90

#Additional config for nrpe.cfg. Will replace matching existing values, or create if required.
nrpe_config: 
  dont_blame_nrpe: 0
```

Dependencies
------------

Testing requires the following roles from Ansible Galaxy:
- src: chrismeyersfsu.provision_docker
  name: provision_docker


Example Playbook
----------------

```
---
- name: Prerequisites and Test
  hosts: all
  become: true
  roles:
    - epel
    - role: nagios_nrpe_client
      vars: 
        nrpe_server_allowed_hosts:
          - 127.0.0.1
          - 10.0.0.0/8
        nrpe_plugin_packages:
          - nagios-plugins-nrpe
          - nagios-plugins
          - nagios-plugins-disk
        nrpe_command:
          check_disk_all:
            script: check_disk
            option: -w 80 -c 90
        nrpe_config: 
          dont_blame_nrpe: 0
```
