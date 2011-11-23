class build {
  package { gcc: ensure => installed }
  package { make: ensure => installed }
  
  # Install additional basic packages
  package { man: ensure => installed }    
}
