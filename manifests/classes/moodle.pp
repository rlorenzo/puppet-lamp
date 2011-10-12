class moodle {
	file { 
   		'/opt/moodledata':
    	ensure => directory,
    	mode   => 0777,
	}
}
