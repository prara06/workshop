# workshop
interview workshops

Pre-reqs: Below will be demonstrated during interview.
1. Azure environment - Workstation, Azure RHEL 7.2 VMs & Hosted Chef
2. Cookbooks are developed on workstation and published on Hosted Chef
3. VM's need to be bootstrapped to Hosted Chef.
4. Cookbooks are added to node run list. (tomcat and mongodb)
5. Can be run multiple times and tested
  - Tomcat : Curl http://localhost:8080
  - Mongodb : mongo

6. FYI receipes can be found 
Git Mongodb Cookbook: 
- workshop/chef-repo/cookbooks/mongodb/recipes/default.rb

Git Tomcat Cookbook: 
- workshop/chef-repo/cookbooks/tomcat/recipes/default.rb
- workshop/chef-repo/cookbooks/tomcat/templates/tomcat.service.erb
