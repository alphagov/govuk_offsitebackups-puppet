# -*- mode: ruby -*-
# vi: set ft=ruby :

VagrantfilePath = File.expand_path(File.dirname(__FILE__))

nodes = {
  'obnode0' => {:ip => '172.16.10.10', :memory => 512},
}
node_defaults = {
  :domain => 'internal',
  :memory => 384,
}

Vagrant.configure("2") do |config|
  config.vm.box     = "puppet-precise64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-1204-x64.box"

  config.vm.synced_folder '.', '/opt/puppet'

  config.vm.provision :shell,
    :inline => 'exec /opt/puppet/tools/bootstrap'
  config.vm.provision :shell,
    :inline => 'exec /opt/puppet/tools/puppet-apply $@',
    :args   => '--verbose --summarize --environment development'

  nodes.each do |node_name, node_opts|
    config.vm.define node_name do |node|
      node_opts = node_defaults.merge(node_opts)
      fqdn = "#{node_name}.#{node_opts[:domain]}"

      node.vm.hostname = fqdn

      if node_opts[:ip]
        node.vm.network(:private_network, :ip => node_opts[:ip])
      end

      node.vm.provider :virtualbox do |vb|
        modifyvm_args = ['modifyvm', :id]
        modifyvm_args << "--name" << fqdn
        if node_opts[:memory]
          modifyvm_args << "--memory" << node_opts[:memory]
        end
        # Isolate guests from host networking.
        modifyvm_args << "--natdnsproxy1" << "on"
        modifyvm_args << "--natdnshostresolver1" << "on"

        file_to_disk_1 = File.join(VagrantfilePath, "#{node_name}_extradisc_1.vdi")
        file_to_disk_2 = File.join(VagrantfilePath, "#{node_name}_extradisc_2.vdi")

        vb.customize(modifyvm_args)
        vb.customize(['createhd', '--filename', file_to_disk_1, '--size', 51200,  "--format", "vdi"])
        vb.customize(['storageattach', :id, '--storagectl','SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk_1])

        vb.customize(['createhd', '--filename', file_to_disk_2, '--size', 51200,  "--format", "vdi"])
        vb.customize(['storageattach', :id, '--storagectl','SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', file_to_disk_2])

      end
    end
  end
end
