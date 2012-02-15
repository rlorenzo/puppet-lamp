# Installs needed packages to get the tex filter working for Moodle
class tex {
	package { "tetex.x86_64": ensure => installed }  
	package { "tetex-doc.x86_64": ensure => installed }  
	package { "tetex-dvips.x86_64": ensure => installed }  
	package { "tetex-fonts.x86_64": ensure => installed }  
	package { "tetex-latex.x86_64": ensure => installed }
	package { "tetex-afm.x86_64": ensure => installed }  
	package { "tetex-xdvi.x86_64": ensure => installed }  
	package { "ImageMagick.x86_64": ensure => installed }  
}
