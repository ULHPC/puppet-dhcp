# File::      <tt>dhcp-params.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPL v3
#
# ------------------------------------------------------------------------------
# = Class: dhcp::params
#
# In this class are defined as variables values that are used in other
# dhcp classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class dhcp::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of dhcp
    $ensure   = 'present'
    # The Protocol used. Used by monitor and firewall class. Default is 'udp'
    $protocol = 'udp'
    # The port number. Used by monitor and firewall class. The default is 67.
    $port     = 67

    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    if ($facts['os']['family'] == 'RedHat' and Integer($facts['os']['release']['major']) <= 7) {
        $support_rsyslog = false
    } else {
        $support_rsyslog = true
    }

    $client_package = $facts['os']['name'] ? {
        /(?i-mx:centos|fedora|redhat|rocky)/ => $facts['os']['release']['major'] ? {
            7       => 'dhclient',
            default => 'dhcp-client'
        },
        /(?i-mx:ubuntu|debian)/              => $facts['os']['distro']['codename'] ? {
            /(?i-mx:wheezy|jessie)/ => 'isc-dhcp-client',
            default                 => 'dhcp3-client'
        },
        default => 'dhcp3-client',
    }

    # DHCP Server configuration
    $server_package = $facts['os']['name'] ? {
        /(?i-mx:centos|fedora|redhat|rocky)/ => $facts['os']['release']['major'] ? {
            7       => 'dhcp',
            default => 'dhcp-server'
        },
        /(?i-mx:ubuntu|debian)/  => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => 'isc-dhcp-server',
            default                         => 'dhcp3-server'
        },
        default => 'dhcp'
    }
    $servicename = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/  => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => 'isc-dhcp-server',
            default                         => 'dhcp3-server'
        },
        default => 'dhcpd'
    }

    # used for pattern in a service ressource
    $processname = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/ => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => 'dhcpd',
            default   => 'dhcpd3'
        },
        default => 'dhcpd',
    }
    $hasstatus = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/              => false,
        /(?i-mx:centos|fedora|redhat|rocky)/ => true,
        default => true,
    }
    $hasrestart = $facts['os']['name'] ? {
        default => true,
    }

    # Configuration file
    $configfile = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/ => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => '/etc/dhcp/dhcpd.conf',
            default                         => '/etc/dhcp3/dhcpd.conf'
        },
        default => '/etc/dhcp/dhcpd.conf'
    }
    $configfile_owner = $facts['os']['name'] ? {
        default => 'root',
    }
    $configfile_group = $facts['os']['name'] ? {
        default => 'root',
    }
    $configfile_mode = $facts['os']['name'] ? {
        default => '0644',
    }

    # Configuration directory
    $configdir = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/ => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => '/etc/dhcp',
            default                         => '/etc/dhcp3'
        },
        default => '/etc/dhcp'
    }
    $configdir_mode = $facts['os']['name'] ? {
        default => '0750',
    }
    $configdir_owner = $facts['os']['name'] ? {
        default => 'root',
    }
    $configdir_group = $facts['os']['name'] ? {
        default => 'root',
    }

    $initconfigfile = $facts['os']['name'] ? {
        /(?i-mx:ubuntu|debian)/ => $facts['os']['distro']['codename'] ? {
            /(?i-mx:squeeze|wheezy|jessie)/ => '/etc/default/isc-dhcp-server',
            default                         => '/etc/default/dhcp3-server',
        },
        default => '/etc/sysconfig/dhcpd',
    }

}
