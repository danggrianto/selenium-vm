name             'selenium-grid'
maintainer       'Daniel Anggrianto'
maintainer_email 'daniel_and_ang@yahoo.com'
license          'All rights reserved'
description      'Installs/Configures selenium-grid'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends          'google-chrome'
depends          'java', '~> 1.6.0'
depends          'supervisor'
depends          'chef_handler'
