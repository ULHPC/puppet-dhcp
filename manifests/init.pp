# File::      <tt>init.pp</tt>
# Author::    Sarah Diehl (Sarah.Diehl@uni.lu)
# Copyright:: Copyright (c) 2015 Sarah Diehl
# License::   GPLv3
#
# ------------------------------------------------------------------------------

class dhcp inherits dhcp::params {
  contain dhcp::server
  contain dhcp::client
}
