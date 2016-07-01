class unoconv {
  $required_packages = [ "asciidoc", "libreoffice", "libreoffice-headless", "python" ]
  package { $required_packages: ensure => "installed" }

  vcsrepo { "/home/vagrant/unoconv":
    ensure => "latest",
    provider => "git",
    source => "https://github.com/dagwieers/unoconv.git",
    require => [
      Package["asciidoc"],
      Package["libreoffice"],
      Package["libreoffice-headless"],
      Package["python"],
    ],
    notify => [ Exec["make_unoconv"] ],
  }

  exec { "make_unoconv":
    command => "/usr/bin/make clean && /usr/bin/make install",
    cwd => "/home/vagrant/unoconv/",
    refreshonly => "true",
    require => [ Package["make"], Vcsrepo["/home/vagrant/unoconv"] ],
  }
}
