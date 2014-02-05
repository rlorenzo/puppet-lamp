class mysql {
  $mysqlpackages = [ "mysql", "mysql-libs", "mysql-server" ]
  package { $mysqlpackages: ensure => "5.5.36-1.el6.remi" }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package["mysql-server"]
  }

  file { "/etc/my.cnf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/my.cnf",
      require => [ Package["mysql-server"] ],
      notify  => Service["mysqld"],
  }
}