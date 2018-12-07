# == Class: ssh
#
class ssh::server (
  Boolean $challenge_response_authentication     = false,
  Ssh::Root::Authentication $root_authentication = false,
  Boolean $password_authentication               = true,
  Boolean $x11_forwading                         = true,
  Boolean $print_mod                             = false,
  Optional[String] $package                      = $server_package,
  Stdlib::Ensure::Serivce $ensure                = 'running',
  Boolean $enabled                               = true,
) {

  $_challenge_response_authentication = bool2str(
    $challenge_response_authentication, 'yes', 'no')
  $_password_authentication           = bool2str(
    $password_authentication, 'yes', 'no')
  $_x11_forwading                     = bool2str(
    $x11_forwading, 'yes', 'no')
  $_print_mod                         = bool2str(
    $print_mod, 'yes', 'no')

  case $root_authentication {
     true, 'yes', 'true':  { $_root_authentication = 'yes' }
     false, 'no', 'false': { $_root_authentication = 'no' }
     default: { $_root_authentication = $root_authentication }
  }

  if $package {
    ensure_packages([$package])
    $require = Package[$package]
  } else {
    $require = undef
  }

  file { '/etc/ssh/sshd_config':
    owner   => 'root',
    group   => $ssh::group,
    mode    => '0644',
    content => template('ssh/sshd_config.erb'),
    require => $require,
    notify  => Service[$ssh::service],
    validate_cmd => 'sshd -t -f %'
  }

  service { "$ssh::service":
    ensure  => $ensure,
    enabled => $enabled
  }
}
