remove_user
=========

This role removes a user account from a Linux system (Ubuntu/RHEL)


Role Variables
--------------

The username of the account to remove
```
user_to_remove_name:
```

Set to 'true' to remove the user's home directory and mail spool
```
user_to_remove_home:
```

Example Playbook
----------------

```
---
- name: Remove a user and remove directories associated with them
  hosts: ansible_workers
  roles:
    - role: remove_user
      user_to_remove_name: "xyz"
      user_to_remove_home: true
```

License
-------

BSD-3-Clause
