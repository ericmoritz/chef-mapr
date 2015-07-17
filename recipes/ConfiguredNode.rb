log "\n=========== Start End Node Config =============\n"


cldb_nodes = node['mapr']['cldb'].join(',')
zk_nodes = node['mapr']['zookeeper'].join(',')
hs_nodes = node['mapr']['historyserver'].join(',')
rm_nodes = node['mapr']['resourcemanager'].join(',')

if node['mapr']['_type_DataNode'] then
  disk_arg = "-D #{node['mapr']['disks']}"
else
  disk_arg = ""
end
command = "./configure.sh -a -N #{node['mapr']['clustername']} -C #{cldb_nodes} -Z #{zk_nodes} -HS #{hs_nodes} -RM #{rm_nodes} #{disk_arg} -on-prompt-cont y"

log "\nmapr #{command}\n"

execute 'Run configure.sh to configure cluster' do
  command command
  cwd "#{node['mapr']['home']}/server"
  user "root"
end
  
  
  
