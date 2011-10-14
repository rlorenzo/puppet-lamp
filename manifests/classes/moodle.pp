class moodle {
	# create directory to store moodle files
	file { 
   		'/opt/moodledata':
    	ensure => directory,
    	mode   => 0777,
	}
	
	# create link to moodle source
	file { "/var/www/html/moodle":
		ensure => link,
		target => "/vagrant/moodle"	
	}
}
