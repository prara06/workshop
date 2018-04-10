#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# Install OpenJDK 7 JDK using yum, run this command:
#$ execute sudo yum install java-1.7.0-openjdk-devel
package 'java-1.7.0-openjdk-devel'


#Create a user for tomcat
#$ sudo groupadd tomcat
group 'tomcat' do
action :create
end

#$ sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
manage_home false
shell '/bin/nologin'
gid 'tomcat'
home '/opt/tomcat'
end

#Download the Tomcat Binary
directory '/opt/tomcat' do
action :create
end

#$ Download tomcat
execute 'wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz' do
cwd '/tmp'
end

# #Extract the Tomcat Binary
# #$ sudo mkdir /opt/tomcat

# #$ sudo tar xvf apache-tomcat-8.5.30.tar.gz  -C /opt/tomcat --strip-components=1
execute 'extract binaries' do 
command 'tar xvf /tmp/apache-tomcat-8.5.30.tar.gz -C /opt/tomcat --strip-components=1'
end 

# #Update the Permissions
#$ sudo chgrp -R tomcat /opt/tomcat
#$ sudo chmod -R g+r conf
#$ sudo chmod g+x conf
#$ sudo chown -R tomcat webapps/ work/ temp/ logs/

execute 'chgrp -R tomcat /opt/tomcat'
execute 'chmod -R g+r /opt/tomcat/conf'
execute 'chmod g+x /opt/tomcat/conf'
execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

#Install the Systemd Unit File
#$ sudo vi /etc/systemd/system/tomcat.service

template '/etc/systemd/system/tomcat.service' do
source 'tomcat.service.erb'
end

# Reload Systemd to load the Tomcat Unit file
# $ sudo systemctl daemon-reload

execute 'systemctl daemon-reload'

# Ensure tomcat is started and enabled
#$ sudo systemctl start tomcat
#$ sudo systemctl enable tomcat

service 'firewalld' do
action [:stop]
end

service 'tomcat' do
action [:start, :enable]
end

#Verify that Tomcat is running by visiting the site
# wait for tomcat to start 
execute 'sleep 5'
execute 'curl http://localhost:8080'