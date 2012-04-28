# Installs needed packages to get the tex filter working for Moodle
class clamav {
	package { "clamd": ensure => installed }
}
