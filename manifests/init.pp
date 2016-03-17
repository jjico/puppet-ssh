# == Class: ssh
#
class ssh (
  $manage_client = true,
  $manage_server = true,
){
  validate_bool($manage_client)
  validate_bool($manage_server)
  if $manage_client {
    class { '::ssh::client': }
  }
  if $manage_server {
    class { '::ssh::server': }
  }

}
