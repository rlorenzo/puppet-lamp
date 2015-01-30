class shifter {

  $shifterpackages = [ "npm", "python", "nodejs" ]
	
  package { $shifterpackages: 
	 ensure => "latest",
	 require => [ Package[epel-release] ]
  }

  exec { "install_shifter":
      command => "npm install shifter@0.4.6 -g",
      path    => "/usr/bin/",
      require => [ Package["npm"] ],
  }  	
}
