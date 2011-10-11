class mysql {

  package { mysql: ensure => latest }
  package { mysql-server: ensure => latest }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package[mysql-server]
  }

  file { "/etc/my.cnf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/my.cnf",
      require => [ Package[mysql-server] ]
  }

}