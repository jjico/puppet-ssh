# == Class: ssh
#
class ssh::client (
  Optional[String] $package = $::ssh::params::client_package,
  Boolean          $check_host_ip = true,
) inherits ssh::params {

  if $check_host_ip {
    $check_host_ip_ensure = 'absent'
  } else {
    $check_host_ip_ensure = 'present'
  }

  if $package {
    ensure_packages([$package])
    $require = Package[$package]
  } else {
    $require = undef
  }
  file_line { 'CheckHostIP':
    ensure  => $check_host_ip_ensure,
    line    => '    CheckHostIP no',
    path    => '/etc/ssh/ssh_config',
    require => $require,
  }
}
