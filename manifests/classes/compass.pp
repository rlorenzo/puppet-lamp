class compass {

    # We need ruby gem installer
    package { 'rubygems' :
        ensure => installed
    }

    # Install compass with gem
    package { 'compass':
        ensure => latest,
        provider => 'gem',
    	require => Package['rubygems']
    }
	
    # Install sass-css-importer. Need to use exec, because need to have the --pre command.
    exec { 'sass-css-importer-install':
    	command => '/usr/bin/gem install --pre sass-css-importer',
    	unless => '/usr/bin/gem list -i sass-css-importer',
    	require => Package['rubygems']
    }

}
