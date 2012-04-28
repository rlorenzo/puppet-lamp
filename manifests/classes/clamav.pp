# Installs and setups clamav
class clamav {
	package { "clamd": ensure => installed }
	
  service {
    clamd:
    enable    => true,
    ensure    => running
  }	
  
  # make sure newest virus definitions are installed
  exec { "freshclam":
      command => "freshclam",
      path    => "/usr/bin/",      
  }    
}
