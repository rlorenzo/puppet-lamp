class phpmyadmin {
	package { phpmyadmin: ensure => installed }  
	
	# make sure that config file is set
    file { "/usr/share/phpmyadmin/config.inc.php":
    	owner   => root,
    	group   => root,
    	mode    => 644,
    	source  => "/vagrant/files/phpmyadmin/config.inc.php",
    	require => Package["phpmyadmin"]
  	}	  	
  	
	# make sure that apache conf file is set
    file { "/etc/httpd/conf.d/phpmyadmin.conf":
    	owner   => root,
    	group   => root,
    	mode    => 644,
    	source  => "/vagrant/files/phpmyadmin/phpmyadmin.conf",
    	require => Package["phpmyadmin"]
  	}  	
}