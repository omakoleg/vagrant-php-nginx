import './packages'

$host_ip = '192.168.10.1'
$mysql_host = '192.168.10.10'
$mysql_root_password = 'vagrant'
$username = 'vagrant'
$password = 'vagrant'
$mysql_db   = 'development'

$nginx_webroot = '/var/www/'
$nginx_server_name = 'local.lc'

$nginx_site1_root = "${nginx_webroot}site1"
$nginx_site2_root = "${nginx_webroot}site2"
$nginx_site1_name = "site1.${nginx_server_name}"
$nginx_site2_name = "site2.${nginx_server_name}"

$nginx_phpmyadmin_name = "phpmyadmin.${nginx_server_name}"
$nginx_phpmyadmin_root = "/usr/share/phpmyadmin"

Exec { path => '/usr/local/bin:/usr/bin:/bin' }

class { 'packages': }
class { 'nginx': }
class { 'php': }

# Setup phpmyadmin. Use login/pass for access
class { 'phpmyadmin': 
  username => $username,
  password => $password,
  mysql_username => 'root',
  mysql_password => $mysql_root_password,
}
# Setup 2 hosts + phpmyadmin
nginx::vhost { $nginx_site1_name :
  root          => $nginx_site1_root,
  index         => 'index.php'
}
nginx::vhost { $nginx_site2_name :
  root          => $nginx_site2_root,
  index         => 'index.php'
}
nginx::vhost { $nginx_phpmyadmin_name :
  root          => $nginx_phpmyadmin_root,
  index         => 'index.php'
}
# Setup service and root password
class { 'mysql::server':
  root_password    => $mysql_root_password,
  restart => true,
  override_options => { 
    'mysqld' => { 
      'max_connections' => '1024',
      'bind-address'    => "192.168.10.10"
    }
  }
} ->
# Create development database
mysql::db { $mysql_db :
  user     => $username,
  password => $password,
  grant    => ['ALL'],
} ->
# Set root password
mysql_user { "root@%" :
  ensure  => 'present',
  password_hash => mysql_password($mysql_root_password)
} ->
# Create remote user
mysql_user { "${username}@${host_ip}" :
  ensure  => 'present',
  password_hash => mysql_password($password)
} ->
# Grant user access
mysql_grant { "${$username}@%/${$mysql_host}.*" :
  ensure     => 'present',
  privileges => ['ALL'],
  table      => "${$mysql_host}.*",
  user       => "${$username}@%"
}