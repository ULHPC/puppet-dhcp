# File::      <tt>dhcp-server.pp</tt>
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
    $ensure = $dhcp::params::ensure
)
inherits dhcp::client
{
    info ("Configuring DHCP server (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("dhcp::server 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include dhcp::server::debian }
        redhat, fedora, centos: { include dhcp::server::redhat }
        default: {
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: dhcp::server::common
#
# Base class to be inherited by the other dhcp::server classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class dhcp::server::common {

    # Load the variables used in this module. Check the dhcp::server-params.pp file
    require dhcp::params
    
    package { 'dhcpd':
        name    => "${dhcp::params::server_package}",
        ensure  => "${dhcp::server::ensure}",
    }

    file { "${dhcp::params::configdir}":
        owner   => "${dhcp::params::configdir_owner}",
        group   => "${dhcp::params::configdir_group}",
        mode    => "${dhcp::params::configdir_mode}",
        ensure  => 'directory',
        require    => Package['dhcpd'],
    }

    file { 'dhcpd.conf':
        path    => "${dhcp::params::configfile}",
        owner   => "${dhcp::params::configfile_owner}",
        group   => "${dhcp::params::configfile_group}",
        mode    => "${dhcp::params::configfile_mode}",
        ensure  => "${dhcp::server::ensure}",
        require => [
                    Package['dhcpd'],
                    File["${dhcp::params::configdir}"],
                    Syslog::Conf['dhcpd']
                    ],
        content => template("dhcp/${site}/dhcpd.conf.erb")
        #content => template("dhcp::server/dhcp::serverconf.erb"),
        #notify  => Service['dhcp::server'],
        #require => Package['dhcp::server'],
    }

    require syslog
    syslog::conf { 'dhcpd':
        ensure => "${dhcp::server::ensure}",
        source => "puppet:///modules/dhcp/rsyslog.conf"
    }
    
    service { 'dhcpd':
        name       => "${dhcp::params::servicename}",
        enable     => true,
        ensure     => running,
        hasrestart => "${dhcp::params::hasrestart}",
        pattern    => "${dhcp::params::processname}",
        hasstatus  => "${dhcp::params::hasstatus}",
        require    => Package['dhcpd'],
        subscribe  => File['dhcpd.conf'],
    }
}


# ------------------------------------------------------------------------------
# = Class: dhcp::server::debian
#
# Specialization class for Debian systems
class dhcp::server::debian inherits dhcp::server::common { }

# ------------------------------------------------------------------------------
# = Class: dhcp::server::redhat
#
# Specialization class for Redhat systems
class dhcp::server::redhat inherits dhcp::server::common { }



