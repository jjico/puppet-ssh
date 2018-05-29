# == Class: ssh
#
class ssh (
  Boolean $manage_client = true,
  Boolean $manage_server = true,
){
  if $manage_client {
    include ssh::client
  }
  if $manage_server {
    include ssh::server
  }
}
