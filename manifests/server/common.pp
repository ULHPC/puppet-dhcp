# File::      <tt>common.pp</tt>
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
                    Rsyslog::Snippet['dhcpd']
                    ],
    }

    if ($dhcp::server::content != undef and $dhcp::server::source == undef) {
        File['dhcpd.conf'] {
            content => $dhcp::server::content
        }
    } elsif ($dhcp::server::content == undef and $dhcp::server::source != undef) {
        File['dhcpd.conf'] {
            source => $dhcp::server::source
        }
    } else {
        fail("dhcp::server 'source' OR 'content' parameter must be set")
    }

    if ! defined(Class['rsyslog::client']) {
        class { 'rsyslog::client': }
    }
    rsyslog::snippet { 'dhcpd':
        content => "if \$syslogtag contains 'dhcpd' then /var/log/dhcpd.log\n& ~",
    }

    if ($dhcp::server::ensure == 'present') {
        $service_ensure = 'running'
    } else {
        $service_ensure = 'stopped'
    }
    service { 'dhcpd':
        ensure     => $service_ensure,
        name       => $dhcp::params::servicename,
        enable     => true,
        hasrestart => $dhcp::params::hasrestart,
        pattern    => $dhcp::params::processname,
        hasstatus  => $dhcp::params::hasstatus,
        require    => Package['dhcpd'],
        subscribe  => File['dhcpd.conf'],
    }
}
