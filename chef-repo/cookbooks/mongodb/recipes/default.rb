#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Configure the package management system (yum).
# Create a /etc/yum.repos.d/mongodb-org-3.6.repo file so that you can install MongoDB directly, using yum.


yum_repository 'mongodb-org-3.6' do
  description "MongoDB Repository"
  baseurl 'https://repo.mongodb.org/yum/redhat/7Server/mongodb-org/3.6/x86_64/'
  gpgcheck true
  enabled true
  gpgkey 'https://www.mongodb.org/static/pgp/server-3.6.asc'
end


# Install the MongoDB packages.
execute 'yum install -y mongodb-org-3.6.3 mongodb-org-server-3.6.3 mongodb-org-shell-3.6.3 mongodb-org-mongos-3.6.3 mongodb-org-tools-3.6.3'

# Configure SELinux - allow relevant ports
execute 'SELINUX=permissive'

# start MongoDB
service 'mongod' do
action [:start, :enable]
end


# Verify that MongoDB has started successfully
execute 'chkconfig mongod on'
execute 'mongo --host 127.0.0.1:27017'