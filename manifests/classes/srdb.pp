class srdb {

  #package { "freetds.x86_64": ensure => installed, disablerepo => "remi" }  
  # need to use old version of freetds to connect, but puppet doesn't
  # yet support "disablerepo" syntax, so do it via command line
  exec { "install_freetds":
      command => "yum --disablerepo=remi -y install freetds",
      path    => "/usr/bin/",      
  }  
  
  file { "/etc/freetds.conf":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/freetds.conf",
      require => [ Package["php-mssql"] ]
  }

  file { "/etc/odbc.ini":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/odbc.ini",
      require => [ Package["php-odbc"] ]
  }

}