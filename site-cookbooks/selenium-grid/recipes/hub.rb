#
# Cookbook Name:: selenium-grid
# Recipe:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'selenium-grid::bats-handler'
include_recipe 'java'
include_recipe 'supervisor'


#
# Install Selenium server
#
directory node['selenium']['dir'] do
    owner 'root'
    group 'root'
    mode 00755
    recursive true
    action :create
end

remote_file "#{node['selenium']['dir']}/#{node['selenium']['jar']}" do
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['selenium']['url']}/#{node['selenium']['jar']}"
    action :create_if_missing
end


#
# Start required services
#
supervisor_service 'hub' do
    user 'root'
    command "java -jar #{node['selenium']['dir']}/#{node['selenium']['jar']} -role hub -port 4444"
end
