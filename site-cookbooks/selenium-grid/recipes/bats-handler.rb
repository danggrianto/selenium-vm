include_recipe "chef_handler"

package 'git-core'

# Accessing an external source is far from ideal but this gives us something to
# iterate on.
git '/root/bats' do
  repository 'https://github.com/sstephenson/bats'
  action :checkout
  notifies :run, 'execute[install BATS]'
end

# Execute only when bats is checked out.
execute 'install BATS' do
  command '/root/bats/install.sh /usr/local'
  action :nothing
end


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