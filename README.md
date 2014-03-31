# GOV.UK Off-site Backups

This is a repository for storing Puppet modules and manifests for use with GOV.UK off-site backups.

## Deployment

If this is the first time that this repository is being applied to a machine,
you need to run:

`fab -u ubuntu -c /dev/null production bodge_sudoers deploy`

The `bodge_sudoers` task allows for passwordless authentication when becoming
sudo as the ubuntu user. This is to allow rsync to start up correctly, without
requiring either an askpass helper or a TTY in which to collect the ubuntu
user's default password.

You only need to run `bodge_sudoers` once. Puppet removes the Ubuntu user and
restores the `sudoers` file back to it's original glory once it has the chance
to run successfully.

If it's not the first time you are applying this repository to a machine, you
can run:

`fab -u ubuntu -c /dev/null production deploy`

The deployment process should take approximately fifteen to twenty minutes.
