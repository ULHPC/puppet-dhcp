# File::      <tt>client.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: dhcp::client
#
# Install and Configure a DHCP client
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of dhcp::client
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import dhcp::client
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'dhcp::client':
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
class dhcp::client( $ensure = $dhcp::params::ensure ) inherits dhcp::params
{
    info ("Configuring dhcp::client (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("dhcp::client 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include dhcp::client::common::debian }
        redhat, fedora, centos: { include dhcp::client::common::redhat }
        default: {
            fail("Module ${::module_name} is not supported on ${::operatingsystem}")
        }
    }
}
