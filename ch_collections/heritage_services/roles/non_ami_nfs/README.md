Ansible Role: non_ami_nfs
This role:
* Installs NFS packages and dependancies 
* Installs an NFS watcher service that monitors all configured NFS mounts for availability, and marks the instance as unhealthy if it us unable to reach a configured mount
* Setup AutoFS for NFS shares when inputs supplied

Compatibility:
- > RHEL/CENTOS 7
- Amazon Linux 2

Example configuration, this contains all available options:
```
- role: nfs_mounts
  vars:
    mounts_timeout: 0
    mounts_parent_dir: "/mounts"
    default_nfs_server_address: "1.2.3.4"
    default_mount_options: [
      "rw",
      "hard",
      "nointr"
    ]
    mounts: 
      remotemountname1:
      remotemountname2:
        local_mount_point: "overridedir" # Overrides the use of the key: remotemountname2 as the mount directory
        mount_options: # Overrides default_mount_options variable
          - "rw"
          - "soft"
          - "intr"
          - "rsize=8192"
          - "wsize=8192"  
      remotemountname3:
        nfs_server_address: "4.3.2.1" # Overrides default_nfs_server_address variable
      remotemountname4:
        nfs_source_mount: "override_source_nfs_share_name" # Overrides the name of the source share name
        local_mount_point: "/mnt/nfs_share" # Overrides mounts_parent_dir variable and the key: remotemountname4 as the mount path and directory
```

This will result in the following mounts:
```
/mounts/remotemountname1      mounted from 1.2.3.4:/remotemountname1 with opts: rw,hard,nointr
/mounts/overridedir           mounted from 1.2.3.4:/remotemountname2 with opts: rw,soft,intr,rsize=8192,wsize=8192
/mounts/remotemountname3      mounted from 4.3.2.1:/remotemountname3 with opts: rw,hard,nointr
/mnt/nfs_share                mounted from 1.2.3.4:/override_source_nfs_share_name with opts: rw,hard,nointr
```
