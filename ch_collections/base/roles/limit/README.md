# Limit

This role has been created to resolve the problem of the root user hitting it's file limits due to the cloudwatch agent. 

The systems default limit is 1024. This role sets a soft limit of 2048 and a hard limit of 65536 and is located in ``/etc/security/limits.d/. It is also changing
the cloudwatch agent systemd service file and adding LimitNOFILE=10000 and LimitNOFILESoft=10000.
> Note files in limits.d/ overright the vaules in the limits file