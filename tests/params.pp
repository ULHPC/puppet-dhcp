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

$names = ["ensure", "protocol", "port", "packagename"]

notice("dhcp::params::ensure = ${dhcp::params::ensure}")
notice("dhcp::params::protocol = ${dhcp::params::protocol}")
notice("dhcp::params::port = ${dhcp::params::port}")
notice("dhcp::params::packagename = ${dhcp::params::packagename}")

#each($names) |$v| {
#    $var = "dhcp::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
