class srdb {

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