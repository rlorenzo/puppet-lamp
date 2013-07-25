class compass {

    # We need ruby gem installer
    package { 'rubygems' :
        ensure => installed
    }

    # Install compass with gem
    package { 'compass':
        ensure => latest,
        provider => 'gem'
    }
}