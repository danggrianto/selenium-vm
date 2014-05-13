#
# Cookbook Name:: selenium-grid
# Recipe:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'selenium-grid::hub'
include_recipe 'selenium-grid::node'