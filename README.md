# ssh

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ssh](#setup)
    * [What ssh affects](#what-ssh-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ssh](#beginning-with-ssh)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Manage client and server](#manage-client-and-server)
    * [SSH client](#ssh-client)
    * [SSH Server](#ssh-server)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and manages openssh-client and openssh-server

## Module Description

This module uses augeas to manage sshd\_config and file\_line to manage ssh\_config  
## Setup

### What ssh affects

* installs ssh client packages
* installes ssh server pacvkages
* manages /etc/ssh/ssh\_config
* manages /etc/ssh/sshd\_config

### Setup Requirements **OPTIONAL**

* stdlib 4.6.0

### Beginning with ssh

just add the ssh class

```puppet
class {'::ssh' }
```

## Usage

### Manage client and server

The main ssh class has two parameters to allow you to decide if you want to 
manage both the client and the server.

```puppet
class {'::ssh' 
  manage_client => false,
  manage_server => true,
}
```

of with hiera

```yaml
ssh::manage_client: false
ssh::manage_server: true
```

### SSH Client

The ssh client currently only supports `CheckHostIP`

```puppet
class {'::ssh::client' 
  check_host_ip => true,
}
```

of with hiera

```yaml
ssh::client::check_host_ip: true
```

### SSH Server

The ssh server class manages a reduced set of parameters used by sshd

```puppet
class {'::ssh::server' 
  password_authentication => false,
  x11_forwading           => false,
}
```

of with hiera

```yaml
ssh::server::password_authentication: false
ssh::server::x11_forwading: false
```

## Reference

### Classes

#### Public Classes

* [`ssh`](#class-ssh)
* [`ssh::client`](#class-sshclient)
* [`ssh::server`](#class-sshserver)

#### Private Classes

* [`ssh::params`](#class-sshparams)

#### Class: `ssh`

Main class, includes all other classes

##### Parameters (all optional)

* `manage_client`: run `ssh::client`. Valid options: 'true' and 'false'. Default: 'false'.
* `manage_server`: run `ssh::server`. Valid options: 'true' and 'false'. Default: 'false'. 

#### Class: `ssh::client`

Manage openssh client

##### Parameters (all optional)

* `package`: Specifies the package to install. Valid options: string. Default: os specific
* `check_host_ip`: Specifies whether to set CheckHostIP. Valid options: 'true' and 'false'. Default: 'false'.

#### Class: `ssh::server`

Manage openssh server

##### Parameters (all optional)

* `package`: Specifies the package to install. Valid options: string. Default: os specific
* `challenge_response_authentication`: Specifies whether to set ChallengeResponseAuthentication. Valid options: 'true' and 'false'. Default: 'false'.
* `password_authentication`: Specifies whether to set PasswordAuthentication. Valid options: 'true' and 'false'. Default: 'true'.
* `x11_forwading`: Specifies whether to set X11Forwarding. Valid options: 'true' and 'false'. Default: 'true'.
* `print_mod`: Specifies whether to set PrintMotd. Valid options: 'true' and 'false'. Default: 'false'.

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

This module is tested on Ubuntu 12.04, and 14.04 and FreeBSD 10 

