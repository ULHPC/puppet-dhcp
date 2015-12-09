# File::      <tt>dhcp-server.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
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
        ensure => $dhcp::server::ensure,
        name   => $dhcp::params::server_package,
    }

    file { $dhcp::params::configdir:
        ensure  => 'directory',
        owner   => $dhcp::params::configdir_owner,
        group   => $dhcp::params::configdir_group,
        mode    => $dhcp::params::configdir_mode,
        require => Package['dhcpd'],
    }

    file { 'dhcpd.conf':
        ensure  => $dhcp::server::ensure,
        path    => $dhcp::params::configfile,
        owner   => $dhcp::params::configfile_owner,
        group   => $dhcp::params::configfile_group,
        mode    => $dhcp::params::configfile_mode,
        require => [
                    Package['dhcpd'],
                    File[$dhcp::params::configdir],
                    Syslog::Conf['dhcpd']
                    ],
        content => template("dhcp/${::site}/dhcpd.conf.erb")
        #content => template("dhcp::server/dhcp::serverconf.erb"),
        #notify  => Service['dhcp::server'],
        #require => Package['dhcp::server'],
    }

    require syslog
    syslog::conf { 'dhcpd':
        ensure => $dhcp::server::ensure,
        source => 'puppet:///modules/dhcp/rsyslog.conf'
    }

    service { 'dhcpd':
        ensure     => running,
        name       => $dhcp::params::servicename,
        enable     => true,
        hasrestart => $dhcp::params::hasrestart,
        pattern    => $dhcp::params::processname,
        hasstatus  => $dhcp::params::hasstatus,
        require    => Package['dhcpd'],
        subscribe  => File['dhcpd.conf'],
    }
}
