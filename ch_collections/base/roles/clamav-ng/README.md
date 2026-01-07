clamav-ng
=========

A one-for-all ClamAV role that installs and configures ClamAV for use within Companies House. This role will also attempt to utilise and, where necessary, clean-up legacy ClamAV configuration baked in to launch AMIs.

The role is written to support the major operating systems in use:
- RHEL
- CentOS
- Amazon Linux
- Ubuntu

As well as the various versions of ClamAV available from the respective vendor repository:
- 0.100.x 
- 0.103.x
- 1.4.x

Note: RHEL 6 support necessitates the use of either Ansible 2.9 or 2.10 due to the version of Python installed on the hosts. As a general guide, the following Ansible versions should work:
- RHEL 6, < Ansible 2.11
- RHEL 8 & 9, >= Ansible 2.10
- CentOS 7, >= Ansible 2.10
- Ubuntu 20.04 (Focal), >= Ansible 2.10
- Ubuntu 24.04 (Noble), >= Ansible 2.15


Requirements
------------

N/A

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

- ansible.posix
- community.general

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
