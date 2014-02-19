include_recipe "chef_handler"

# Install `bats-chef-handler` gem during the compile phase
chef_gem "bats-chef-handler"

# load the gem here so it gets added to the $LOAD_PATH, otherwise chef_handler
# will fail.
require 'chef/handler/bats_handler'

# Activate the handler immediately during compile phase
chef_handler "Chef::Handler::BatsHandler" do
  source "chef/handler/bats_handler"
  action :nothing
end.run_action(:enable)