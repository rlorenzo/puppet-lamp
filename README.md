h3. Introduction
This project allows CCLE developers to automatically create a virtual image that is running the same LAMP stack that is being used for our Moodle 2.0 servers to help develop code in a production like environment.

NOTE: Please make sure you have "Virtualization Technology" or the equivalent setting enabled on your computer's BIOS.

Install VirtualBox
https://www.virtualbox.org/

Install Vagrant by following the guide at this website:
http://vagrantup.com/v1/docs/getting-started/index.html

Check out vagrant/puppet scripts that will be creating CCLE's centos box
* cd ~/Projects
* git clone git://github.com/rlorenzo/puppet-lamp.git moodle20

Checkout CCLE 2.0 codebase from Github
* cd  ~/Projects/moodle20
* git clone git@github.com:ucla/moodle.git (if you have ssh keys setup)
* git clone https://&lt;github account&gt;@github.com/ucla/moodle.git (if you want to type in your password)

Running vagrant/puppet scripts to setup CCLE's centos box
* vagrant up

Pre-moodle install setup
* First ssh into the vagrant image: vagrant ssh
* Create moodle database
** mysql &#8208;&#8208;user=root &#8208;&#8208;execute='CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;'
* Create moodle user and allow them to access moodle database (replace &lt;PASSWORD&gt; with something)
** mysql &#8208;&#8208;user=root &#8208;&#8208;execute="GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost' IDENTIFIED BY '&lt;PASSWORD&gt;'; FLUSH PRIVILEGES;"

Setup moodle
* Go to localhost:8080/moodle/install.php and follow setup wizard
* Choose /opt/moodledata for the "Data Directory"
* For database connection "Type" choose MySQLi
* Enter in the database user/password you created above.
* Next Moodle will say that it cannot create a config.php file and you will need to manually create it yourself. Please do the following:
** On the vagrant box filesystem, for your moodle script directory, create a link to the dev configuration file
*** Using the host computer
*** cd ~/Projects/moodle20/moodle
*** ln -s local/ucla/config/shared_dev_moodle-config.php config.php
** Then create a file called 'config_private.php' in the ~/Projects/moodle20/moodle directory with the database password and other details that Moodle prompted you to create for the configuration file. 
*** Be sure to remove the lines:
unset($CFG);
global $CFG;
$CFG = new stdClass();
...
require_once(dirname(__FILE__) . '/lib/setup.php');
*** You can put other configuration data that should not go into version control in this file such as more passwords and salts.
**** Also include $CFG-&gt;divertallemailsto = '&lt;your email address&gt;';

Also, here are some post-install instructions:

Setting default theme
# Go to Site administration &gt; Appearance &gt; Themes &gt; Theme selector
# Click "choose" for the  "default" row
# Find "UCLA Theme" and then click "Use theme"
# Click "Continue"

Install US English language pack
# Go to Site administration > Language > Language packs
## Under list of available languages choose "English - United States (en_us)" and click "Install selected language pack"
# Go to Site administration > Language > Language settings
## Select "English - United States (en_us)" for "Default language"
## Click "Save changes"
# Change everyone's default language to en_us
## Run SQL query: UPDATE `mdl_user` SET lang='en_us' WHERE lang='en';

Seeding data
# Import sql files in local/ucla/db/seed_data into your Moodle database

PHPunit problems

For some reason, sometimes PHPunit doesn't install from the puppet scripts. Please manually install PHPunit by sshing into the VM and running the following command:

sudo pear config-set auto_discover 1
sudo pear install pear.phpunit.de/PHPUnit
sudo pear install --alldeps phpunit/DbUnit

Then in your config_private.php file, please add: 

$CFG->phpunit_dataroot = '/opt/phpu_moodledata';
$CFG->phpunit_prefix = 'phpu_';

h3. NOTES

phpMyAdmin is viewable at: http://localhost:8080/phpmyadmin

If you want to use a database dump that includes some pre-built courses and users please do the following:
# Install
## Download the database dump file at: https://m2.ccle.ucla.edu/rex/new_moodle_instance.sql
## Dump your current moodle database and import the dump file
### If you saved the database dump file to your ~/Projects/moodle20 directory, please ssh into your VM and do the following:
#### cd /vagrant
#### mysql -u root
#### DROP DATABASE moodle;
#### CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
#### USE moodle;
#### SOURCE new_moodle_instance.sql
## Change the salt of your configuration file to be: $CFG-&gt;passwordsaltmain = 'a_very_long_salt_string';
# This database dump includes the following user accounts (login/pass):
## admin/test
## instructor/test
## student/test
# The database dump includes the following items:
## roles copied from our production server
## turned off most of the password requirements so that simple passwords can be used for test accounts
## Some recent courses

---
To setup a 1.9 development environment, you can do the steps above, but change the following:
* Use this image for the vagrant box
**vagrant box add vagrant-centos5.7-64 https://m2dev.ccle.ucla.edu/rex/vagrant/vagrant-centos5.7-64.box
* Edit Vagrantfile have this line instead:
** config.vm.box = "vagrant-centos5.7-64"
* Edit manifests/classes/moodle.pp to have this line instead:
** target =&gt; "/vagrant/moodle/moodle"
* Edit files/etc/apc.ini to have this line instead:
** apc.shm_size = 48

---
If you upgrade VirtualBox your Vagrant image might not be able to mount your directory, because you need to update your VirtualBox guest additions.

* SSH into your vagrant image: vagrant ssh
* Go to http://download.virtualbox.org/virtualbox/ and download the latest copy of VBoxGuestAdditions_X.iso for your version of VirtualBox onto /tmp
* As root:
** mount -o loop -t iso9660 /tmp/VBoxGuestAdditions_X.iso /mnt
** sh /mnt/VBoxLinuxAdditions.run

---
h3. Caveats for Windows users

* Git Bash does not support symbolic links. After you do the step of "create a link to the dev configuration file" please 
realize that you are essentially copying the file. Any updates made to the development configuration file will need to be 
manually updated by you. Also, since the file is now a copy change the following line:
** $_dirroot_ = dirname(realpath(__FILE__)) . '/../../..'; into $_dirroot_ = dirname(realpath(__FILE__));
* You will not be able to "vagrant ssh" into your virtual machine. You will need to use putty to ssh. But before you can do 
that you will need to convert the the vagrant ssh key into a putty ppk file. Please follow this link for more information: 
http://wazem.blogspot.com/2007/11/how-to-convert-idrsa-keys-to-putty-ppk.html