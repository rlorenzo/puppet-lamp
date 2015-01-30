class build {
  package { gcc: ensure => installed }
  package { make: ensure => installed }
  
  # Install additional basic packages
  package { man: ensure => installed }    

	  # Make sure certain repos are installed.
	  package { 'epel-release':
	    provider => 'rpm',
		ensure => present,
		source => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'  
	  }
		  package { 'remi-release':
	    provider => 'rpm',
		ensure => present,
		source => 'http://rpms.famillecollet.com/enterprise/remi-release-6.rpm'  
	  }
	  package { 'rpmforge-release':
	    provider => 'rpm',
		ensure => present,
		source => 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'  
	  }
	  # Enable remi repo.
	  file { "/etc/yum.repos.d/remi.repo":
	    owner   => root,
		group   => root,
		mode    => 644,
		source  => "/vagrant/files/etc/yum.repos.d/remi.repo",
		require => [ Package[remi-release] ],
	   }  

}
