#
# Cookbook Name:: attributes
# Recipe:: autoupdates
#
# Copyright (c) 2018 The Authors, All Rights Reserved.


case node['platform']
when 'ubuntu'

        execute "apt-update" do
                command "apt-get -y update"
                action :run
        end

#Install all packages and security updates.
        execute "apt-upgrade" do
                command "apt-get dist-upgrade -y"
                action :run
        end

        bash "check running services" do
        code <<-EOH
                service --status-all | grep '[+]' | awk -F ']' {'print $2'} > /var/log/before_reboot.txt
                EOH
        end

# Reboot the system after chef-client run
        include_recipe 'autoupdates::reboot'

when 'oracle'
        execute 'clean-yum-cache' do
                command 'yum clean all'
                action :run
        end

        execute 'yum update' do
                command 'yum update -y'
                action :run
        end

        case node['platform_version']
        when '7.4'
        bash "check running services" do
        code <<-EOH
                 systemctl list-unit-files --state==enabled | awk -F ' ' {'print $1'} > /var/log/before_reboot.txt
                EOH
        end
        when '6.4'
        bash "check running services" do
        code <<-EOH
                service --status-all | grep '[running]' | awk -F ' ' {'print $1'} > /var/log/before_reboot.txt
                EOH
        end
        include_recipe'autoupdates::reboot'

end