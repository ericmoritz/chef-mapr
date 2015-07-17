default['mapr']['uid'] = 5000
default['mapr']['gid'] = 5000
default['mapr']['user'] = 'mapr'
default['mapr']['group'] = 'mapr'
default['mapr']['password'] = '$1$xNo/jY/u$LWqlJIzEzFqbmZv6aemsR1'
default['root']['password'] = '$1$ck3SLdAA$SO8yFTYXpEFAt07ld3d8d/'
default['ntp']['servers'] = ["'0.pool.ntp.org', '1.pool.ntp.org'"]
default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'

default['mapr']['home'] = '/opt/mapr'
default['mapr']['clustername'] = 'my_cluster'
default['mapr']['version'] = '4.0.2'
default['mapr']['repo_url'] = 'http//package.mapr.com/releases'
default['mapr']['disks'] = '/dev/sdb'

# TODO: Auto Discover these hostnames

# cldb hostnames
default['mapr']['cldb'] = []

# zookeeper hostnames
default['mapr']['zookeeper'] = []

# historyserver hostnames
default['mapr']['historyserver'] = []

# resourcemanager hostnames
default['mapr']['resourcemanager'] = []

