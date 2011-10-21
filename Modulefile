name       'dhcp'
version    '0.0.2'
source     'git-admin.uni.lu:puppet-repo.git'
author     'Sebastien Varrette (Sebastien.Varrette@uni.lu)'
license    'GPL v3'
summary    'Configure DHCP client and server'
description 'Configure DHCP client and server'
project_page 'UNKNOWN'

## List of the classes defined in this module
classes    'dhcp::server, dhcp::server::common, dhcp::server::debian, dhcp::server::redhat, dhcp::client, dhcp::client::common, dhcp::client::debian, dhcp::client::redhat, dhcp::params'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency 'syslog'
defines    '[]'
