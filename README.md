# GOV.UK Off-site Backups

IaaS provisioning, Puppet, and deployment code for GOV.UK off-site backup
machine.

## Testing

To test changes made to this repository, first ensure that you have
[Vagrant](http://vagrantup.com) installed, and then:

1. Run `vagrant up` from the root of this repository
2. When the box has booted successfully, run `vagrant ssh obnode0` to SSH to
the guest

The machine always builds against the current branch of the repository.
Thus, if you branch from master, make a change, then bring the Vagrant VM
up, your changes should be reflected. It is best to `vagrant destroy` your
virtual machine (to destroy it) if you wish to make another change, unless
it is trivial - in which case you can run `vagrant provision obnode0` to
re-run Puppet against it.

## Deployment Setup - Install Fabric (ideally in a virtualenv)

    pip install -r requirements.txt

## Deployment

If this is the first time that this repository is being applied to a machine,
you need to run:

    fab -c /dev/null production firstrun

This `firstrun` task is to allow rsync to start up correctly, without
requiring either an askpass helper or a TTY in which to collect the ubuntu
user's default password: passwordless authentication as the ubuntu user is
temporarily enabled.

After the first run, Puppet removes the Ubuntu user and restores the `sudoers` file back to it's
original glory once it has the chance to run successfully.

If it's not the first time you are applying this repository to a machine, you
can run:

    fab -c /dev/null -u YOUR_SSH_USERNAME production deploy
