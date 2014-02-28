#
# Cookbook Name:: selenium-grid
# Recipe:: node
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'selenium-grid::bats-handler'
include_recipe 'java'
include_recipe 'supervisor'
include_recipe 'google-chrome'
node.override['selenium-grid']['grid']['hub']['url'] = '192.168.10.10'

#
# Install packages
#
%w(firefox x11vnc xorg unzip).each do |pkg|
  package pkg do
    action :install
  end
end

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
# Chromedriver
#
remote_file "#{node['selenium']['dir']}/#{node['chromedriver']['zip']}" do
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['chromedriver']['url']}/#{node['chromedriver']['version']}/#{node['chromedriver']['zip']}"
    action :create
end

execute "unzip" do
  cwd "#{node['selenium']['dir']}"
  command "unzip -o #{node['chromedriver']['zip']}"
  action :run
end

#
# config
#
template "#{node['selenium']['dir']}/#{node['selenium']['config']}.json" do
  source "#{node['selenium']['config']}.erb"
  owner 'root'
  variables({
    :hub_url => node['grid']['hub']['url'],
    :node_url => node['grid']['node']['url']
    })
end


#
# Start required services
#
supervisor_service 'startx' do
    command 'startx'
    user 'root'
    notifies :start, 'supervisor_service[x11vnc]'
    action [ :enable, :start ]
end

supervisor_service 'x11vnc' do
    command 'x11vnc -safer -httpdir /usr/share/vnc-java/ -httpport 5800'
    user 'root'
    notifies :start, 'supervisor_service[node]'
    action [ :enable, :start ]
end


supervisor_service 'node' do
    environment 'DISPLAY' => ':0'
    user 'root'
    command %W{
    java -jar #{node['selenium']['dir']}/#{node['selenium']['jar']}
      -role node -nodeConfig #{node['selenium']['dir']}/#{node['selenium']['config']}.json
      -Dwebdriver.chrome.driver=#{node['selenium']['dir']}/#{node['chromedriver']['exe']}
    }.join(' ')
end
