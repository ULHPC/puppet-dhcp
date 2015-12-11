# File::      <tt>params.pp</tt>
# Author::    UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'dhcp::params'

$names = ['ensure', 'protocol', 'port', 'client_package', 'server_package',
          'servicename', 'processname', 'hasstatus', 'hasrestart', 'configfile',
          'configfile_owner', 'configfile_group', 'configfile_mode',
          'configdir', 'configdir_mode', 'configdir_owner', 'configdir_group',
          'initconfigfile']

notice("dhcp::params::ensure = ${dhcp::params::ensure}")
notice("dhcp::params::protocol = ${dhcp::params::protocol}")
notice("dhcp::params::port = ${dhcp::params::port}")
notice("dhcp::params::client_package = ${dhcp::params::client_package}")
notice("dhcp::params::server_package = ${dhcp::params::server_package}")
notice("dhcp::params::servicename = ${dhcp::params::servicename}")
notice("dhcp::params::processname = ${dhcp::params::processname}")
notice("dhcp::params::hasstatus = ${dhcp::params::hasstatus}")
notice("dhcp::params::hasrestart = ${dhcp::params::hasrestart}")
notice("dhcp::params::configfile = ${dhcp::params::configfile}")
notice("dhcp::params::configfile_owner = ${dhcp::params::configfile_owner}")
notice("dhcp::params::configfile_group = ${dhcp::params::configfile_group}")
notice("dhcp::params::configfile_mode = ${dhcp::params::configfile_mode}")
notice("dhcp::params::configdir = ${dhcp::params::configdir}")
notice("dhcp::params::configdir_mode = ${dhcp::params::configdir_mode}")
notice("dhcp::params::configdir_owner = ${dhcp::params::configdir_owner}")
notice("dhcp::params::configdir_group = ${dhcp::params::configdir_group}")
notice("dhcp::params::initconfigfile = ${dhcp::params::initconfigfile}")

#each($names) |$v| {
#    $var = "dhcp::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
