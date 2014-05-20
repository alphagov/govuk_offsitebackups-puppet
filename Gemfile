source 'https://rubygems.org'

# Versions can be overridden with environment variables for matrix testing.
# Travis will remove Gemfile.lock before installing deps. As such, it is
# advisable to pin major versions in this Gemfile.

# Dependency management.
gem 'librarian-puppet'

# Puppet core.
gem 'facter', ENV['FACTER_VERSION'] || '~> 1.7.0'
gem 'puppet', ENV['PUPPET_VERSION'] || '~> 3.4.0'

# Testing utilities.
gem 'puppet-syntax'
gem 'puppet-lint', '~> 0.3.0'
gem 'puppetlabs_spec_helper', '~> 0.4.0'
gem 'rake'
gem 'rspec-puppet', '~> 0.1.0'

# vCloud tools
gem 'vcloud-core'
gem 'vcloud-edge_gateway'
gem 'vcloud-tools', :github => 'alphagov/vcloud-tools'
gem 'vcloud-walker'
