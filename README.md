# consul-template

Install and configure Consul-Template

Requirements
------------
- Ansible 2.2+
- Ubuntu (14.04+)

Role Variables
--------------
See [defaults/main.yml](defaults/main.yml) for a list and description of
variables used in this role.

Dependencies
------------
TODO: Add role dependencies.

Description
-----------
Installs consul-template as `/usr/local/bin/consul-template`, creates a configuration
directory at `/etc/consul-template/conf.d`, and a basic configuration file at
`/etc/consul-template/conf.d/config.json` based on the settings provided in the
`consul_template_config` dictionary.

You can configure consul-template further by dropping your own configuration
files into `/etc/consul-template/conf.d`, or by extending `consul_template_config`.

Example Playbook
----------------
TODO: Add example playbook(s).

```yaml
- hosts: servers
  roles:
     - role: consul-template
```
