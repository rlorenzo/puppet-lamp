class mysql {

  package { "mysql.x86_64": ensure => installed }
  package { "mysql-libs.x86_64": ensure => installed }
  package { "perl-DBD-mysql": ensure => installed }
  package { "mysqlclient15.x86_64": ensure => installed }
  package { "mysql-server.x86_64": ensure => installed }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package["mysql-server.x86_64"]
  }

  file { "/etc/my.cnf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/my.cnf",
      require => [ Package["mysql-server.x86_64"] ]
  }

}