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
  package { "php-xml.x86_64": ensure => installed }      
  package { php-soap: ensure => installed }     
  package { php-intl: ensure => installed }  
  package { php-xmlrpc: ensure => installed }   
  
  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/php.ini",
      require => [ Package[php] ]
  }

  # install apc
  package { php-pear: ensure => installed }
  package { "php-devel.x86_64": ensure => installed }
  package { "httpd-devel.x86_64": ensure => installed }   
  package { "pcre-devel.x86_64": ensure => installed }   

  package { php-pecl-apc: ensure => installed }

  file { "/etc/php.d/apc.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/php.d/apc.ini"
  }
  
  # install xdebug
  package { php-pecl-xdebug: ensure => installed }  
  
  file { "/etc/php.d/xdebug.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/php.d/xdebug.ini"
  }
}