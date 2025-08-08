Role Name
=========

OS_Tools reporting role - gathers various information from systems in .txt format (and upload it)

Requirements
------------

Steps needs to be performed before executing the role
==============================================================
1) Create **reports** folder in the same directory as your playbook.yml

The working directory should look something like this
=====================================================
```
.
├── playbook.yml
├── reports/
├── roles/
│   └── ostool_report
```

Role Variables
--------------

```
tmp_path_file: ""
```
Path for temporary files, recommend not to change
```
output_path: ""
```
Path for temporary files, recommend not to change

Example Playbook
----------------

playbook.yml
- If you move the playbook somewhere else, make sure to update role path var
- role: '/home/path/to/roles/ostools_report'

```
---
- name: Create OS_Tools CSV report
  hosts: ansible_workers
  gather_facts: true
  roles:
    - role: ostools_report

```

