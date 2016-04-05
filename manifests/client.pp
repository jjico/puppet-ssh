# == Class: ssh
#
class ssh::client (
  $package       = $::ssh::params::client_package,
  $check_host_ip = true,
) inherits ssh::params {

  validate_string($package)
  validate_bool($check_host_ip)

  if $check_host_ip {
    $check_host_ip_ensure = 'absent'
  } else {
    $check_host_ip_ensure = 'present'
  }

  if $package {
    ensure_packages([$package])
  }

  file_line { 'CheckHostIP':
    ensure  => $check_host_ip_ensure,
    line    => '    CheckHostIP no',
    path    => '/etc/ssh/ssh_config',
    require => Package[$package],
  }
}
