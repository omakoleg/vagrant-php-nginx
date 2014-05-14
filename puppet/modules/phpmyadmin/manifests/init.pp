class phpmyadmin(
  $mysql_username = 'root',
  $mysql_password = 'root',
  $username       = 'root',
  $password       = 'root',
  $host           = 'localhost',
  $port           = 3306
){
  package { ["php5", "php5-mysql"] :
    ensure => installed,
    notify  => Service['php5-fpm']
  }
  package { 'phpmyadmin' :
    ensure => installed,
    require => Package['php5', 'mysql-server']
  }
  file { "/usr/share/phpmyadmin/config.inc.php":
    ensure  => 'present',
    content => template("phpmyadmin/config.inc.php.erb"),
    require => Package['phpmyadmin']
  }
}