# == Class: ssh::params
#
# This class manages SSH parameters
#
# === Parameters:
# [$service] 
#   the name of the service to manage
# [$client_package]
#    the name of the client ssh package
# [$server_package]
#    the name of the server ssh package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh::params {
  if  $::osfamily == 'Debian' {
    $service        = 'ssh'
    $client_package = 'openssh-client'
    $server_package = 'openssh-server'
  } elsif $::osfamily == 'FreeBSD' {
    $service        = 'sshd'
    $client_package = undef
    $server_package = undef
  }
}
