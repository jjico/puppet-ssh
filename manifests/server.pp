# == Class: ssh
#
class ssh::server (
  String $package                           = $::ssh::params::server_package,
  Boolean $challenge_response_authentication = false,
  Boolean $password_authentication           = true,
  Boolean $x11_forwading                     = true,
  Boolean $print_mod                         = false,
) inherits ssh::params {

  $_challenge_response_authentication = bool2str(
    $challenge_response_authentication, 'yes', 'no')
  $_password_authentication           = bool2str(
    $password_authentication, 'yes', 'no')
  $_x11_forwading                     = bool2str(
    $x11_forwading, 'yes', 'no')
  $_print_mod                         = bool2str(
    $print_mod, 'yes', 'no')

  if $package {
    ensure_packages([$package])
    $require = Package[$package]
  } else {
    $require = undef
  }
  augeas {'/etc/ssh/sshd_config':
    context => '/files/etc/ssh/sshd_config',
    require => $require,
    changes => [
      "set ChallengeResponseAuthentication ${_challenge_response_authentication}",
      "set PasswordAuthentication ${_password_authentication}",
      "set X11Forwarding ${_x11_forwading}",
      "set PrintMotd ${_print_mod}",
    ],
  }
}
