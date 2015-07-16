log "\n=========== Start MapR Node Config =============\n"

directory '/tmp' do
  owner 'root'
  group 'root'
  mode '1777'
  action :create
end


if Mixlib::ShellOut.new('getenforce') != 'Disabled'
  execute 'Setting SeLinux to Permissive mode' do
    command 'setenforce 0'
    action :run
  end

  ruby_block 'Turn off SELinux' do
    block do
      file  = Chef::Util::FileEdit.new('/etc/selinux/config')
      file.search_file_replace_line('SELINUX=enforcing', 'SELINUX=disabled')
      file.search_file_replace_line('SELINUX=enforcing', 'SELINUX=disabled')
      file.write_file
    end
  end
end

package 'bash'
package 'rpcbind'
package 'dmidecode'
package 'glibc'
package 'hdparm'
package 'initscripts'
package 'iputils'
package 'irqbalance'
package 'libgcc'
package 'libstdc++'
package 'redhat-lsb-core'
package 'rpm-libs'
package 'sdparm'
package 'shadow-utils'
package 'syslinux'
package 'unzip'
package 'zip'
package 'nc'
package 'wget'
package 'git'
package 'nfs-utils'
package 'nfs-utils-lib'
package 'git'
package 'gcc'
package 'patch'
package 'dstat'
package 'lsof'

java_version = node['java']['version']

bash 'Install Java' do
  code <<-EOH
    yum -y install #{java_version}
  EOH
end

# Add JAVA_HOME to /etc/profile
ruby_block 'Set JAVA_HOME in /etc/profile' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/profile')
    file.insert_line_if_no_match('export JAVA_HOME=#{node[:java][:home]}', '\nexport JAVA_HOME=#{node[:java][:home]}')
    file.insert_line_if_no_match('export EDITOR=vi', 'export EDITOR=vi')
    file.write_file
  end
end

bash 'turn_on_rpcbind' do
  code <<-EOH
    service rpcbind start
    chkconfig rpcbind on
  EOH
end

service 'iptables' do
  action [:stop, :disable]
end

include_recipe 'ntp'


group node['mapr']['group'] do
  gid node['mapr']['gid']
end

user node['mapr']['user'] do
  uid node['mapr']['uid']
  gid node['mapr']['gid']
  shell '/bin/bash'
  home "/home/#{node['mapr']['user']}"
end

user 'setting mapr password' do
  username node['mapr']['user']
  password node['mapr']['password']
  action :modify
end

directory "/home/#{node['mapr']['user']}" do
  owner node['mapr']['user']
  group node['mapr']['group']
  mode 0700
end

ruby_block 'Add mapr to /etc/sudoers' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/sudoers')
    file.insert_line_after_match('root    ALL=(ALL)       ALL', 'mapr	ALL=(ALL) 	ALL')
    file.insert_line_if_no_match('mapr      ALL=(ALL)       ALL', 'mapr      ALL=(ALL)       ALL')
    file.write_file
  end
end

include_recipe "mapr::_validate_host"
