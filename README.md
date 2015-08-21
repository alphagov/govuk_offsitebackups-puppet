# GOV.UK Off-site Backups

IaaS provisioning, Puppet, and deployment code for GOV.UK off-site backup
machine.

## Testing

To test changes made to this repository, first ensure that you have
[Vagrant](http://vagrantup.com) installed, and then:

1. Run `vagrant up` from the root of this repository
1. When the box has booted successfully, run `vagrant ssh obnode0` to SSH to
the guest
1. Run `vagrant provision` to apply subsequent changes to the Puppet
codebase.

## Deployment Setup - Install Fabric (ideally in a virtualenv)

    pip install -r requirements.txt

## Deployment

If this is the first time that this repository is being applied to a machine,
you need to run:

    fab -c /dev/null production <provider> firstrun

`provider` needs to be set to either:
  - `provider0` for Skyscape
  - `provider1` for Carrenza

This `firstrun` task is to allow rsync to start up correctly, without
requiring either an askpass helper or a TTY in which to collect the ubuntu
user's default password: passwordless authentication as the ubuntu user is
temporarily enabled.

After the first run, Puppet removes the Ubuntu user and restores the `sudoers` file back to it's
original glory once it has the chance to run successfully.

If it's not the first time you are applying this repository to a machine, you
can run:

    fab -c /dev/null -u <username> production <provider> deploy

`provider` needs to be set to either:
  - `provider0` for Skyscape
  - `provider1` for Carrenza
