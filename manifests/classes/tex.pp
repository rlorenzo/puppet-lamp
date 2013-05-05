# Installs needed packages to get the tex filter working for Moodle
class tex {
	package { "texlive.x86_64": ensure => installed }  
	package { "ImageMagick.x86_64": ensure => installed }  
}
