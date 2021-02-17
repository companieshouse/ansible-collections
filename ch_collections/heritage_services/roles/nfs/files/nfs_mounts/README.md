# Ansible Role: nfs_mounts
Ansible role designed for local run on servers to manage the configuration of NFS mounts using runtime inputs from a mechanism such as AWS userdata.

Example configuration:
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
        local_mount_point: "overridedir"
        mount_options: 
          - "rw"
          - "soft"
          - "intr"
          - "rsize=8192"
          - "wsize=8192"  
      remotemountname3:
        nfs_server_address: "4.3.2.1"
```

This will result in the following mounts:
```
/mounts/remotemountname1      mounted from 1.2.3.4:/remotemountname1 with opts: rw,hard,nointr
/mounts/overridedir           mounted from 1.2.3.4:/remotemountname2 with opts: rw,soft,intr,rsize=8192,wsize=8192
/mounts/remotemountname3      mounted from 4.3.2.1:/remotemountname3 with opts: rw,hard,nointr
```
