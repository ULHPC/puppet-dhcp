# Dhcp Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/ULHPC/dhcp.svg)](https://forge.puppetlabs.com/ULHPC/dhcp)
[![License](http://img.shields.io/:license-GPL3.0-blue.svg)](LICENSE)
![Supported Platforms](http://img.shields.io/badge/platform-debian-lightgrey.svg)

Configure DHCP client and server

      Copyright (c) 2026 UL HPC Team <hpc-sysadmins@uni.lu>


| [Project Page](https://github.com/ULHPC/puppet-dhcp) | [Sources](https://github.com/ULHPC/puppet-dhcp) | [Issues](https://github.com/ULHPC/puppet-dhcp/issues) |

## Synopsis

Configure DHCP client and server.

This module implements the following elements:

* __Puppet classes__:
    - `dhcp`
    - `dhcp::client`
    - `dhcp::client::common`
    - `dhcp::client::debian`
    - `dhcp::client::redhat`
    - `dhcp::params`
    - `dhcp::server`
    - `dhcp::server::common`
    - `dhcp::server::debian`
    - `dhcp::server::redhat`

* __Puppet definitions__:

All these components are configured through a set of variables you will find in
[`manifests/params.pp`](manifests/params.pp).

## Dependencies

See [`metadata.json`](metadata.json). In particular, this module depends on

* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)
* [puppet/rsyslog](https://forge.puppetlabs.com/puppet/rsyslog)

## Overview and Usage

### Class `dhcp`

This is the main class defined in this module.

Use it as follows:

     include 'dhcp'

## Librarian-Puppet / R10K Setup

You can of course configure the dhcp module in your `Puppetfile` to make it available with [Librarian puppet](http://librarian-puppet.com/) or
[r10k](https://github.com/adrienthebo/r10k) by adding the following entry:

     # Modules from the Puppet Forge
     mod "ULHPC/dhcp"

or, if you prefer to work on the git version:

     mod "ULHPC/dhcp",
         :git => 'https://github.com/ULHPC/puppet-dhcp',
         :ref => 'main'

## Developments / Issues / Contributing to the code

This Puppet Module has been implemented in the context of the [UL HPC](http://hpc.uni.lu) Platform of the [University of Luxembourg](http://www.uni.lu).
It relies on [Vox Pupuli modulesync](https://github.com/voxpupuli/modulesync) for its organization.

You can submit bugs / issues / feature requests using the [ULHPC/dhcp Puppet Module Tracker](https://github.com/ULHPC/puppet-dhcp/issues).
You are more than welcome to contribute to its development by [sending a pull request](https://help.github.com/articles/using-pull-requests).

## Licence

This project and the sources proposed within this repository are released under the terms of the [GPL-3.0](LICENCE) licence.


[![Licence](https://www.gnu.org/graphics/gplv3-88x31.png)](LICENSE)
