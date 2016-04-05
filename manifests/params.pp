# == Class: ssh::params
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
