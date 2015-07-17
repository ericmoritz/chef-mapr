# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
$vb_gui = false
$vb_memory = 1024 * 4
$vb_cpus = 1
$num_instances = 3

# A cluster of 3 nodes
$cluster = [
  # Main Node
  [
    "recipe[mapr::Node]",
    "recipe[mapr::ZookeeperNode]",
    "recipe[mapr::EdgeNode]",
    "recipe[mapr::JobCoordinationNode]",
    "recipe[mapr::DataCoordinationNode]",
    "recipe[mapr::ConfiguredNode]",
  ],
  
  # 2 Data Nodes
  [
    "recipe[mapr::Node]",
    "recipe[mapr::ZookeeperNode]",
    "recipe[mapr::WorkerNode]",
    "recipe[mapr::ConfiguredNode]",
  ],

  [
    "recipe[mapr::Node]",
    "recipe[mapr::ZookeeperNode]",
    "recipe[mapr::WorkerNode]",
    "recipe[mapr::ConfiguredNode]",
  ]
]


def dataDrive(vm, size, hostname)
  file_to_disk = "./#{hostname}-sdb.vdi"

  unless File.exist?(file_to_disk)
    vm.customize ['createhd', '--filename', file_to_disk,
                  '--size',size]
  end
  
  vm.customize ['storageattach', :id, '--storagectl',
                'IDE Controller', '--port', 1, '--device', 0,
                '--type', 'hdd', '--medium', file_to_disk]
end

Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-6.6"

  # vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  config.vm.provider :virtualbox do |vb|
    vb.gui = $vb_gui
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
    
  end

  (1..$num_instances).each do |i|
    config.vm.define "node-#{i}" do |config|
      run_list = $cluster[i-1]
      config.vm.network :private_network, ip: "172.17.9.#{i+100}"

      if run_list.include? "recipe[mapr::EdgeNode]" then
        config.vm.network :forwarded_port,
                          guest: 8443,
                          host: 8443 + (i-1) * 10
      end

      config.vm.hostname = "node-#{i}"

      config.vm.provider "virtualbox" do | v |
        dataDrive(v, 500 * 1024, config.vm.hostname)
      end

      config.vm.provision :chef_solo do |chef|
        chef.run_list = run_list
        chef.json = {
          # TODO: Auto Discover these settings
          "mapr" => {
            "cldb" => ["node-1"],
            "zookeeper" => ["node-1", "node-2", "node-3"],
            "historyserver" => ["node-1"],
            "resourcemanager" => ["node-1"]
          }
        }
      end
    end
  end

end
