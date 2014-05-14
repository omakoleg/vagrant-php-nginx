About
=======
Small vargant box (ubuntu precise64 based) with php-fpm , mysql, phpmyadmin and nginx
Clone using 'git clone --recursive' to fetch all submodules

Requirements
------
Vagrant [vagrant](http://www.vagrantup.com/)
Virtual Box [virtual box](https://www.virtualbox.org)

Nginx 
------
By dafault there are 2 sites for usage:

	site1.local.lc
	site2.local.lc
Site contents available in 'public' folder

Mysql 
------
There are 2 users:
root: vagrant
vagrant: vagrant

Remote access granted for both:

	mysql -h192.168.10.10 -uroot -pvagrant
	mysql -h192.168.10.10 -uvagrant -pvagrant
	
Test database 'development' also present

Phpmyadmin
------
Available at phpmyadmin.local.lc with mysql credentials

Php-fpm
------
Connected thru 127.0.0.1:9000

Licence
------
licensed under a MIT licence [link](http://opensource.org/licenses/MIT)
