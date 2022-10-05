# Limit

This role has been created to resolve the problem of the root user hitting it's file limits due to the cloudwatch agent. 

The systems default is 1024. This role sets a soft limit of 1024 and a hard limit of 65536 and is located in ``/etc/security/limits.d/

> Note files in limits.d/ overright the vaules in the limits file

