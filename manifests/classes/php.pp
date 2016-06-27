class php {

  package { php:
	ensure => latest,
	require => [ File["/etc/yum.repos.d/remi.repo"]]
  }
  
  $phppackages = [ "php-mcrypt", "php-mysqlnd", "php-mssql", "php-odbc", "gd", "gd-devel", 
  				   "php-gd", "php-mbstring", "php-xml", "php-soap", "php-intl", "php-xmlrpc" ]
  package { $phppackages: ensure => "installed",
  	 					require => [ Package[php] ] }

  # Custom configs for php.ini and opcache.ini
  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/php.ini",
      require => [ Package[php] ],
  }

  # install xdebug
  package { php-pecl-xdebug: ensure => installed }

}
