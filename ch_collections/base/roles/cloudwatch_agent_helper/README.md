cloudwatch_agent_helper
=========

A role to setup cloudwatch agent helper scripts for configuring application specific logging on instances.


Requirements
------------

Assumes that Cloudwatch Agent is configured on the server.


Role Variables
--------------

script_dir: Directory to place helper scripts into, if not provided defaults to the home directory of the executing user.

Dependencies
------------

None

Example Playbook
----------------

```
---
- name: Prerequisites and Test
  hosts: all
  become: true
  roles:
    - geerlingguy.ansible-role-repo-epel
    - https://github.com/companieshouse/ansible-role-amazon-cloudwatch-agent.git
      vars:
        cwa_conf_json_file_content: "{{ lookup('file', 'files/cloudwatch-config.json') }}"
    - cloudwatch_agent_helper

```
