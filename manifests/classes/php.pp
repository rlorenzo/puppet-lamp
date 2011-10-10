class php {

  package { php: ensure => installed }  
  package { php-mcrypt: ensure => installed }
  package { php-mysql: ensure => installed }
  package { php-mssql: ensure => installed }
  package { php-odbc: ensure => installed }

  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/php.ini",
      require => [ Package[php] ]
  }

}