vCloud Provisioning Tools
=========================

This folder contains supporting tools for provisioning off-site backup machines
in vCloud environments. You'll find...

- README.md: this file; it's used to tell you what's what and such. You should
  probably read this.

- bootstrap_preamble.erb: a templated Ruby bootstrap script applied to new
  boxes. It's included in `offsite-backup-1.yaml`, which also handles applying
  the boostrap script to machines it creates.

- offsite-backup-1.yaml: a YAML file for use with vcloud-launch to bring up an
  off-site backup machine.
