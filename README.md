### Introduction
This project allows CCLE developers to automatically create a virtual image that is running the same LAMP stack that is being used for our Moodle 2 servers to help develop code in a production like environment.

### Prerequisites
* Please make sure you have “Virtualization Technology” or the equivalent setting enabled on your computer’s BIOS.
* Install VirtualBox 4.2.12: https://www.virtualbox.org/wiki/Downloads
* Install Vagrant 1.2.2: http://downloads.vagrantup.com
* Access to the CCLE codebase. Note, you can use this Vagrant image for vanilla Moodle, just ignore or skip the steps related to the CCLE codebase.
    * Make sure you are using SSH keys to access to the CCLE codebase: https://help.github.com/articles/generating-ssh-keys   

### Download and setup dev image
1. Check out vagrant/puppet scripts that will be creating CCLE’s centos box
    * mkdir ~/Projects && cd ~/Projects
    * git clone git://github.com/rlorenzo/puppet-lamp.git ccle
2. Checkout CCLE the codebase from Github
    * cd ~/Projects/ccle
    * git clone git@github.com:ucla/moodle.git
    * cd moodle
    * git submodule init && git submodule update
3. Runn the vagrant/puppet scripts to setup the CCLE dev image
   * vagrant up

### Pre-moodle install
1. First ssh into the vagrant image: 
   * vagrant ssh
2. Create moodle database
   * mysql --user=root --execute="CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
3. Create moodle user and allow them to access moodle database
   * mysql --user=root --execute="GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost' IDENTIFIED BY 'test'; FLUSH PRIVILEGES;"
      * Can replace 'test' with any other password you want to use.

### Setup CCLE version of Moodle
1. Go to localhost:8080/moodle/install.php and follow setup wizard
2. Choose /opt/moodledata for the “Data Directory”
3. For database connection “Type” choose MySQLi
4. Enter in the database user/password you created above, which could be moodle/test
5. Next Moodle will say that it cannot create a config.php file and you will need to manually create it yourself. Please do the following:
   * On the host computer, create a link to the dev configuration file
      * cd ~/Projects/ccle/moodle
      * ln -s local/ucla/config/shared_dev_moodle-config.php config.php
6. Then create a file called ‘config_private.php’ in the ~/Projects/ccle/moodle directory with the database password and other details that Moodle prompted you to create for the configuration file.
   * Be sure to remove the lines:

```php
unset($CFG);
global $CFG;
$CFG = new stdClass();
...
require_once(dirname(FILE) . ‘/lib/setup.php’);
```
   * You can put other configuration data that should not go into version control in this file such as more passwords and salts.
   * **Also include $CFG->divertallemailsto = ‘<your email address>’;**
7. Import a sample database dump that includes prebuild courses, config settings, roles, and a set of test users.
   * vagrant ssh
   * mysql -u root -D moodle -o < wget https://test.ccle.ucla.edu/vagrant/new_moodle_instance.sql
   * Change the salt of your config_private.php file to be: $CFG->passwordsaltmain = ‘a_very_long_salt_string’;
   * This database dump includes the following user accounts (login/pass):
      * admin/test
      * instructor/test
      * student/test
   * The database dump includes the following items:
      * roles copied from our production server
      * turned off most of the password requirements so that simple passwords can be used for test accounts
      * pre-built courses
8. Install PHPUnit by following the directions at http://docs.moodle.org/dev/PHPUnit#Installation_of_PHPUnit_via_Composer

### NOTES
1. phpMyAdmin is viewable at: http://localhost:8080/phpmyadmin
2. You can gain root access by doing: sudo su -
3. If you upgrade VirtualBox your Vagrant image might not be able to mount your directory, because you need to update your VirtualBox guest additions.
   * SSH into your vagrant image: vagrant ssh
   * Go to http://download.virtualbox.org/virtualbox/ and download the latest copy of VBoxGuestAdditions\_X.iso for your version of VirtualBox onto /tmp
   * As root (sudo su -):
      * mount -o ro -t iso9660 /tmp/VBoxGuestAdditions\_X.iso /mnt
      * sh /mnt/VBoxLinuxAdditions.run

### Caveats for Windows users
* Git Bash does not support symbolic links. After you do the step of “create a link to the dev configuration file” please     realize that you are essentially copying the file. Any updates made to the development configuration file will need to be     manually updated by you. Also, since the file is now a copy change the following line:

   ```php
    $_dirroot_ = dirname(realpath(__FILE__)) . '/../../..'; into
    $_dirroot_ = dirname(realpath(__FILE__));
   ```
* You will not be able to “vagrant ssh” into your virtual machine. You will need to use putty to ssh. But before you can do     that you will need to convert the the vagrant ssh key into a putty ppk file. Please follow this link for more information:     http://wazem.blogspot.com/2007/11/how-to-convert-idrsa-keys-to-putty-ppk.html
