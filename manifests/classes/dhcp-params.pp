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
    $ensure = $dhcp_ensure ? {
        ''      => 'present',
        default => "${dhcp_ensure}"
    }

    # The Protocol used. Used by monitor and firewall class. Default is 'udp'
    $protocol = $dhcp_protocol ? {
        ''      => 'udp', # isn't it at the ethernet ? 
    }
    # The port number. Used by monitor and firewall class. The default is 67.
    $port = $dhcp_port ? {
        ''      => 67,
        default => "${dhcp_port}",
    }
    
    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    $client_package = $::operatingsystem ? {
        default => 'dhcp3-client',
    }

    # DHCP Server configuration
    $server_package = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/  => $::lsbdistcodename ? {
            'squeeze' => 'isc-dhcp-server',
            default   => 'dhcp3-server'
        },
        default                 => 'dhcp'
    }
    $servicename = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/  => $::lsbdistcodename ? {
            'squeeze' => 'isc-dhcp-server',
            default   => 'dhcp3-server'
        },
        default                 => 'dhcpd'
    }

    # used for pattern in a service ressource
    $processname = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => $::lsbdistcodename ? {
            'squeeze' => 'dhcpd',
            default   => 'dhcpd3'
        },
        default => 'dhcpd',
    }
    $hasstatus = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/        => false,
        /(?i-mx:centos|fedora|redhat)/ => true,
        default => true,
    }
    $hasrestart = $::operatingsystem ? {
        default => true,
    }

    # Configuration file
    $configfile = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => $::lsbdistcodename ? {
            'squeeze' => '/etc/dhcp/dhcpd.conf',
            default   => '/etc/dhcp3/dhcpd.conf'
        },
        default => '/etc/dhcpd.conf'
    }
    $configfile_owner = $::operatingsystem ? {
        default => 'root',
    }
    $configfile_group = $::operatingsystem ? {
        default => 'root',
    }
    $configfile_mode = $::operatingsystem ? {
        default => '0644',
    }

    # Configuration directory
    $configdir = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => $::lsbdistcodename ? {
            'squeeze' => '/etc/dhcp',
            default   => '/etc/dhcp3'
        },
        default  => '/etc/dhcp'
    }
    $configdir_mode = $::operatingsystem ? {
        default => '0750',
    }
    $configdir_owner = $::operatingsystem ? {
        default => 'root',
    }
    $configdir_group = $::operatingsystem ? {
        default => 'root',
    }

    $initconfigfile = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => $::lsbdistcodename ? {
            'squeeze' => '/etc/default/isc-dhcp-server',
            default   => '/etc/default/dhcp3-server',
        },
        default => '/etc/sysconfig/dhcpd',
    }

    
    # 
    # $pkgmanager = $::operatingsystem ? {
    #     /(?i-mx:ubuntu|debian)/	       => [ '/usr/bin/apt-get' ],
    #     /(?i-mx:centos|fedora|redhat)/ => [ '/bin/rpm', '/usr/bin/up2date', '/usr/bin/yum' ],
    #     default => []
    # }


}

