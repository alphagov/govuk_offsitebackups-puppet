# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = {
  'node0' => {:ip => '172.16.10.1', :memory => 512},
  'node1' => {:ip => '172.16.10.2'},
  'node2' => {:ip => '172.16.10.3'},
}

Vagrant.configure("2") do |config|
  config.vm.box     = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = "site.pp"
    puppet.manifests_path = "manifests"
    puppet.module_path    = [ "modules", "vendor/modules" ]
  end

  nodes.each do |node_name, node_opts|
    config.vm.define node_name do |node|
      node.vm.hostname = node_name

      if node_opts[:ip]
        node.vm.network(:private_network, :ip => node_opts[:ip])
      end

      config.vm.provider :virtualbox do |vb|
        modifyvm_args = ['modifyvm', :id]
        if node_opts[:memory]
          modifyvm_args << "--memory" << node_opts[:memory]
        end
        # Isolate guests from host networking.
        modifyvm_args << "--natdnsproxy1" << "on"
        modifyvm_args << "--natdnshostresolver1" << "on"
        vb.customize(modifyvm_args)
      end
    end
  end
end
