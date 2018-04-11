# Class: puppet_chocolatey_foreman
# ===========================
#
# Full description of class puppet_chocolatey_foreman here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'puppet_chocolatey_foreman':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class puppet_chocolatey_foreman (
    $package_install = '',
    $package_latest  = '',
    $package_absent  = ''
  ) {
    if $facts['os']['family'] == 'windows' {

        notify { 'puppet_chocolatey_foreman - Windows OS detected.': }
        include chocolatey

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
              ensure   => installed,
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
                ensure   => installed,
                provider => chocolatey,
            }
          }
        }
    }


  }
