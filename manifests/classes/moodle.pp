class moodle {
	# create directory to store moodle files
	file { 
   		'/opt/moodledata':
    	ensure => directory,
    	mode   => 0777,
	}

	# create directory to store moodle phpunit files
	file { 
   		'/opt/phpu_moodledata':
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
	
	# course creator fails if sendmail is not installed	
	# NOTE: This means that the VM can potentially send email out
	# Please use caution when using scripts that send out email
	package { sendmail: ensure => installed }  

	# setup moodle cron
	cron {
		moodle_cron:
			command => "/usr/bin/php /vagrant/moodle/admin/cron.php",
			user => vagrant,
			minute => '*/30',
			require => Service["vixie-cron"]
	}	
}
