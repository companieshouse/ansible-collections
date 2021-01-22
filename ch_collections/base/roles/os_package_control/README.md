# Ansible Role: os_package_control

This Ansible role allows users to control the packages installed on the OS.
Any packages that are installed from additional repositories cannot be installed unless you also include that repository on the server, it will not be installed by this role.

Installed packages from RedHat:
openssl
openssh-server