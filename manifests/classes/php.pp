class php {

  package { php: ensure => installed }  
  package { php-mcrypt: ensure => installed }
  package { php-mysql: ensure => installed }
  package { php-mssql: ensure => installed }
  package { php-odbc: ensure => installed }
  package { gd: ensure => installed }
  package { gd-devel: ensure => installed }
  package { php-gd: ensure => installed }
  package { php-mbstring: ensure => installed }
  package { php-xmlrpc: ensure => installed }  

  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/php.ini",
      require => [ Package[php] ]
  }

}