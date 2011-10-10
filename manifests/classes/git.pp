class git {

  package { zlib-devel: ensure => installed }
  package { openssl-devel: ensure => installed }
  package { curl-devel: ensure => installed }
  package { expat-devel: ensure => installed }
  package { gettext-devel: ensure => installed }
  package { wget: ensure => installed }

  package { git: ensure => installed }
}
