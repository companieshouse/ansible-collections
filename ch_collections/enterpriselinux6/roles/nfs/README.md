Ansible Role: nfs
This role:
* Is a clone of the heritage_services/nfs role, with some changes to suppor the python requirements of RHEL 6 systems.
* Installs NFS packages and dependancies 
* Installs an NFS watcher service that monitors all configured NFS mounts for availability, and marks the instance as unhealthy if it us unable to reach a configured mount
* Places an NFS setup role onto the instance that can be used by runtime configuration playbooks to create and manage NFS mounts (see files/nfs_mounts/README.md)
