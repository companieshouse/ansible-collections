# AMI testing

A simple docker setup to cover testing of Ansible. Requires ansible and docker to be installed on the local host.

To test, first ensure you have all required role dependancies installed: 
```
ansible-galaxy install -r requirements.yml
```

Then we can execute the playbook. This will create a docker container based on Centos6 and Centos7 and execute the playbook in both.
```
ansible-playbook test.yml
```
