class phpmyadmin {
	# clone phpmyadmin if it doesn't exist
	exec { "install_phpmyadmin":
   		command => "/usr/bin/git clone https://github.com/phpmyadmin/phpmyadmin.git /var/www/html/phpmyadmin",
    	unless => "/usr/bin/test -d /var/www/html/phpmyadmin",
	}	

	# update phpmyadmin if it is a git repo
	exec { "update_phpmyadmin":
   		command => "/usr/bin/cd /var/www/html/phpmyadmin; /usr/bin/git pull",
    	unless => "/usr/bin/test -d /var/www/html/phpmyadmin/.git",
	}		
	
	# make sure that config file is set
    file { "/var/www/html/phpmyadmin/config.inc.php":
    	owner   => root,
    	group   => root,
    	mode    => 644,
    	source  => "/vagrant/files/phpmyadmin/config.inc.php",
    	require => Exec["install_phpmyadmin"]
  	}	  	
}