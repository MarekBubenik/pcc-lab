authselect_pam
=========

Setup PAM using Authselect on RHEL 8+ systems

Requirements
------------

The working directory should look something like this
=====================================================
```
.
├── playbook.yml
├── roles/
│   └── authselect_pam
```

Role Variables
--------------

```
backup_config: ""
```
Perform backup of a current profile?
```
backup_file: ""
```
Name of the authselect backup file, changeable, can keep as it is
```
custom_profile_name: ""
```
Name of the custom profile
```
custom_profile_base: ""
```
Based on which profile we will create a new custom profile
```
authselect_features: ""
```
Which authselect features to enable
```
password_quality: ""
```
Key/value variables for pwquality module

Example Playbook
----------------

playbook.yml
- If you move the playbook somewhere else, make sure to update role path var
- role: '/home/path/to/roles/authselect_pam'

```
---
- name: Configure PAM using authselect on RHEL 8+
  hosts: ansible_workers
  roles:
    - role: authselect_pam

```