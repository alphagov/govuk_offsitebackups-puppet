#!/usr/bin/env python

from fabric.api import *
from fabric.contrib.project import rsync_project

import atexit
import shutil
import tempfile
import os
import glob

env.dest = '/opt/puppet'
env.repo = 'git://github.com/alphagov/govuk_offsitebackups-puppet.git'

@task
@runs_once
def production():
    env.environment = 'production'
    env.hosts = [
        'backup0.backup.provider0.production.govuk.service.gov.uk',
#       'backup0.backup.provider1.production.govuk.service.gov.uk',
        ]

@task
@runs_once
def development():
    env.environment = 'development'
    env.skip_bad_hosts = True
    env.hosts = [
        '172.16.10.10',
        ]

@task
def deploy():
    tempdir = puppet_package()
    puppet_transfer(tempdir)
    puppet_run()

def bodge_sudoers():
  sudo('echo "ubuntu ALL= NOPASSWD:/usr/bin/rsync" | tee -a /etc/sudoers')

@task
def firstrun():
  env.user='ubuntu'
  bodge_sudoers()
  deploy()

@runs_once
def puppet_package():
    tempdir = tempfile.mkdtemp()
    atexit.register(shutil.rmtree, tempdir)

    local('git clone -b squash-disks %s %s/.' % (env.repo, tempdir))

    with lcd(tempdir):
        local('bundle install --quiet')
        local('bundle exec rake')
        local('bundle exec librarian-puppet install')
        local('git clean -ffdx --exclude "vendor"')

    return tempdir

def puppet_transfer(tempdir):
    sudo('which rsync || apt-get install -qq rsync')
    rsync_project(
        env.dest,
        tempdir + '/',
        exclude = './.git',
        delete = True,
        extra_opts = '--rsync-path="sudo rsync" --checksum --quiet'
        )

def puppet_run():
    sudo('/opt/puppet/tools/bootstrap')
    sudo('/opt/puppet/tools/puppet-apply --environment %s' % env.environment)
