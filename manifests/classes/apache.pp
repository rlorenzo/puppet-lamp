class apache {
  package { httpd: ensure => "2.2.15-29.el6.centos" }
  package { httpd-devel: ensure => installed }
  package { mod_ssl: ensure => installed }

  service {
    httpd:
    enable    => true,
    ensure    => running,
    subscribe => [Package[httpd], File["/etc/httpd/conf/httpd.conf"], Package[php], File["/etc/php.ini"]]
  }

  file { "/etc/httpd/conf/httpd.conf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/httpd/conf/httpd.conf",
      require => [ Package[httpd] ]
  }
}