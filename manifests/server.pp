# File::      <tt>server.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: dhcp::server
#
# Configure the DHCP server
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of dhcp
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import dhcp::server
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'dhcp::server':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class dhcp::server(
    $ensure  = $dhcp::params::ensure,
    $content = undef,
    $source  = undef
)
inherits dhcp::client
{
    info ("Configuring DHCP server (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("dhcp::server 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        'debian', 'ubuntu':         { include dhcp::server::common::debian }
        'redhat', 'fedora', 'centos': { include dhcp::server::common::redhat }
        default: {
            fail("Module ${::module_name} is not supported on ${::operatingsystem}")
        }
    }
}
