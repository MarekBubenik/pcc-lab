Role Name
=========

OpenSCAP Compliance Reporting role - does **not** do remediation


Requirements
------------

https://www.open-scap.org/security-policies/choosing-policy/

Install pre-req on master Ansible server - Ubuntu:
```
apt install ssg-base ssg-debderived ssg-debian ssg-nondebian ssg-applications
```

Install pre-req on master Ansible server - RHEL:
```
dnf install scap-security-guide
```


Fetch the relevant **datastream** from the **/usr/share/xml/scap/ssg/content/** directory

Create a symlink of a datastream role's files directory so Ansible can use it
```
ln -s /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml files/ssg-cs9-ds.xml
```
```
ln -s /usr/share/xml/scap/ssh/content/ssg-ubuntu2204-ds.xml files/ssg-ubuntu2204-ds.xml
```
- Or just create the .xml file from scrach and upload it to the files/ directory of the role

Fetch the **profile ID** from the profile based on the datastream you chose
```
oscap info /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```
```
xccdf_org.ssgproject.content_profile_cis_server_l1
```
- Make sure to **edit variables in playbook** to the coresponding datastream policies and profile IDs


Role Variables
--------------
```
debPolicyName:
```
Ubuntu datastream file (e.g. ssg-ubuntu2204-ds.xml)
```
rpmPolicyName:
```
RedHat datastream file (e.g. ssg-cs9-ds.xml)
```
debProfileID:
```
Ubuntu profile ID from the datastream file (E.g. xccdf_org.ssgproject content_profile_cis_level1_server)
```
rpmProfileID:
```
RedHat profile ID from the datastream file (E.g. xccdf_org.ssgproject.content_profile_cis_server_l1)


Example Playbook
----------------

reporting_openscap.yml
- If you move the playbook somewhere else, make sure to update role path var
- role: '/home/path/to/roles/openscap_report'

```
---
- name: OpenSCAP Compliance Reporting
  hosts: ansible_workers
  roles:
    - role: openscap_report
      debPolicyName: ssg-ubuntu2204-ds.xml
      rpmPolicyName: ssg-cs9-ds.xml
      debProfileID: xccdf_org.ssgproject.content_profile_cis_level1_server
      rpmProfileID: xccdf_org.ssgproject.content_profile_cis_server_l1
```

License
-------

BSD-3-Clause

