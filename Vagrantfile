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
  ["recipe[mapr::Node]",
   "recipe[mapr::ZookeeperNode]",
   "recipe[mapr::EdgeNode]",
   "recipe[mapr::JobCoordinationNode]",
   "recipe[mapr::DataCoordinationNode]"],
  
  # 2 Data Nodes
  ["recipe[mapr::Node]", "recipe[mapr::ZookeeperNode]", "recipe[mapr::WorkerNode]"],

  ["recipe[mapr::Node]", "recipe[mapr::ZookeeperNode]", "recipe[mapr::WorkerNode]"],  
]


Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-6.6"

  config.vm.provider :virtualbox do |vb|
    vb.gui = $vb_gui
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
  end

  (1..$num_instances).each do |i|
    config.vm.define "node-#{i}" do |config|
      config.vm.network :private_network, ip: "172.17.9.#{i+100}"
      config.vm.hostname = "node-#{i}"

      config.vm.provision :chef_solo do |chef|
        chef.run_list = $cluster[i]
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
