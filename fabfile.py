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
        'backup0.backup.provider1.production.govuk.service.gov.uk',
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
#    puppet_merge_hieradata(tempdir)
    puppet_transfer(tempdir)
    puppet_run()

@runs_once
def puppet_package():
    tempdir = tempfile.mkdtemp()
    atexit.register(shutil.rmtree, tempdir)

    local('git clone %s %s/.' % (env.repo, tempdir))

    with lcd(tempdir):
        local('bundle install --quiet')
        local('bundle exec rake')
        local('bundle exec librarian-puppet install')
        local('git clean -ffdx --exclude "vendor"')

    return tempdir

@runs_once
def puppet_merge_hieradata(tempdir):
    for file_name in glob.glob("./hieradata/*.yaml"):
      src = file_name
      dest = os.path.join(tempdir, file_name)
      print src, dest
      if os.path.exists(src) and os.path.exists(dest):
          # We don't want to potentially overwrite all the hieradata, so to avoid
          # confusion this aborts the whole deploy.
          abort('%s is present in deployment and puppet repos' % file_name)
      shutil.copyfile(src, dest)

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
