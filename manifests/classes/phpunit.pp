# Code from:
# http://matteolandi.blogspot.com/2012/01/about-cakephp-and-vagrant.html
class phpunit {
	exec { "phpunit":
    	command => "/usr/bin/pear upgrade pear && \
        	        /usr/bin/pear channel-discover pear.phpunit.de && \
            	    /usr/bin/pear channel-discover components.ez.no && \
                	/usr/bin/pear channel-discover pear.symfony-project.com && \
                	/usr/bin/pear install --alldeps phpunit/PHPUnit",
    	creates => "/usr/bin/phpunit",
    	require => Package["php-pear"],
	}
}