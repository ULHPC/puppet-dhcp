# File::      <tt>dhcp-client.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: dhcp::client::common
#
# Base class to be inherited by the other dhcp::client classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class dhcp::client::common {

    # Load the variables used in this module. Check the dhcp-params.pp file
    require dhcp::params

    package { $dhcp::params::client_package:
        ensure  => $dhcp::client::ensure,
    }

}
