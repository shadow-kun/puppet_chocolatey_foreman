# Class: puppet_chocolatey_foreman
# ===========================
#
# This module is designed to take array of chocolatey applications as Parameters
# and puppet will either install, keep updated, or remove them. It is designed
# to be used in conjunction with foreman with smart parameter input, though can
# be used on its own as well.
#
# Parameters
# ----------
#
# * `package_install`
# This parameter can be either entered as a single string or as an array. It
# will then ensure that each package is installed via chocolatey. Once a package
# is installed it will not automatically update it.
# Default value is an empty string.
#
# * `package_latest`
# This parameter can be either entered as a single string or as an array. It
# will then ensure that each package is installed via chocolatey along with
# updating the package to the latest version if required.
# Default value is an empty string.
#
# * `package_absent`
# This parameter can be either entered as a single string or as an array. It
# will then ensure that each package is removed from the system via chocolatey.
# Default value is an empty string.
#
# * `chocolatey_internal_server`
#
# This parameter can be either left blank or a value can be entered pointing to
# a chocolatey server. This to allow packages to be hosted internally which is
# the preferred method of chocolatey. Default value is an empty string.
#
# * `chocolatey_internal_only`
# This boolean parameter is either true or false to state if chocolatey is to
# use the internal server only. The default value is false.
#
# Variables
# ----------
#
# * `$facts['os']['family']`
# This variable uses the family OS variable to ensure that chocolatey Packages
# are only run on a windows device.
#
# Examples
# --------
#
# @example
#    class { 'puppet_chocolatey_foreman':
#      package_install => [ 'adobereader', 'firefox' ],
#      package_latest => 'notepadplusplus',
#      package_absent => [ 'safari' ],
#      chocolatey_internal_server => 'http://chocolatey.server.lan',
#      chocolatey_internal_only => false,
#    }
#
# Authors
# -------
#
# Shadow Reaper <shadowreaper@shadowreaper.net>
#
# Copyright
# ---------
#
# Copyright 2018 ZoR Systems, unless otherwise noted.
#
class puppet_chocolatey_foreman (
    $chocolatey_internal_server = '',
    $chocolatey_internal_only = false,
    $package_install = '',
    $package_latest  = '',
    $package_absent  = ''
  ) {
    if $facts['os']['family'] == 'windows' {

        notify { 'puppet_chocolatey_foreman - Windows OS detected.': }
        include chocolatey

        # checks to see if an internal server source is set.
        if(!$chocolatey_internal_server.empty)
        {
          # Sets internal server settings and makes it the primary source
          chocolateysource {'internal':
            ensure   => present,
            location => $chocolatey_internal_server,
            priority => 1,
          }

          # Sets if required internal sources only.
          if($chocolatey_internal_only == true)
          {
            chocolateysource {'chocolatey':
              ensure => disabled,
            }
          }
        }

        # Installs the application(s) listed if missing only
        if(!$package_install.empty)
        {
          $package_install.each
          |Integer $p_install_index, String $p_install_value| {
            package { $p_install_value:
              ensure   => installed,
              provider => chocolatey,
            }
          }
        }


        # Installs the latest known version of application(s) listed
        if(!$package_latest.empty)
        {
          $package_latest.each
          |Integer $p_latest_index, String $p_latest_value| {
            package { $p_latest_value:
              ensure   => latest,
              provider => chocolatey,
            }
          }
        }

        # Uninstalls all application(s) listed
        if(!$package_absent.empty)
        {
          $package_absent.each
          |Integer $p_absent_index, String $p_absent_value| {
            package { $p_absent_value:
                ensure   => absent,
                provider => chocolatey,
            }
          }
        }
    }


  }
