class moodle {
	# create directory to store moodle files
	file { 
   		'/vagrant/moodledata':
    	ensure => directory,
    	mode   => 0777,
	}
	
	# create link to moodle source
	file { "/var/www/html/moodle":
		ensure => link,
		target => "/vagrant/moodle"	
	}
	
	# make sure aspell is installed
	package { "aspell.x86_64": ensure => installed }  
	
	# although sendmail will not work, course creator fails
	# if sendmail is not installed	
	package { sendmail: ensure => installed }  

	# setup moodle cron
	cron {
		moodle_cron:
			command => "/var/www/html/moodle/admin/cron.php",
			user => vagrant,
			minute => '*/30',
			require => Service["vixie-cron"]
	}	
}
