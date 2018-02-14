#
# Cookbook Name:: attributes
# Recipe:: default
#
# Copyright (c) 2018 The Authors, All Rights Reserved.


log "the node platform is #{node['platform']}"
log "the node platform version is #{node['platform_version']}"

case node['platform']
	when 'redhat'
		log "my system is redhat"
	when 'centos'
		log "my system is centos #{node['platfrom']}"
		if node['platform_version'] >= '7' || node['platform_version'] < '8'
			log "my system platofrm is #{node['platform_version']}" ### write your own script by replacing this line
		elsif node['platform_version'] >= '6' || node['platform_version'] < '7'
			log "my system platform is #{node['platform_version']}" ### write your own script by replacing this line
		end
end
		