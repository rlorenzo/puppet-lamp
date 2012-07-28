# Code from:
# https://github.com/khoomeister/puppet-devbox/blob/master/modules/lamp/manifests/init.pp
class phpunit {
	exec { '/usr/bin/pear upgrade pear':
		require => Package['php-pear'],
		user => root,
	}

	define discoverPearChannel {
		exec { "/usr/bin/pear channel-discover $name":
			onlyif => "/usr/bin/pear channel-info $name | grep \"Unknown channel\"",
			require => Exec['/usr/bin/pear upgrade pear'],
			user => root,
		}
	}
	discoverPearChannel { 'pear.phpunit.de': }
	discoverPearChannel { 'components.ez.no': }
	discoverPearChannel { 'pear.symfony-project.com': }

	exec { '/usr/bin/pear install pear.phpunit.de/PHPUnit':
		onlyif => "/usr/bin/pear info phpunit/PHPUnit | grep \"No information found\"",
		require => [
			Exec['/usr/bin/pear upgrade pear'],
			DiscoverPearChannel['pear.phpunit.de'],
			DiscoverPearChannel['components.ez.no'],
			DiscoverPearChannel['pear.symfony-project.com']
		],
		user => root,
	}
}