define nginx::vhost(
  $root,
	$index = 'index.html',
	$server_name = $name
){
  file { "/etc/nginx/sites-enabled/${$name}.conf":
    ensure  => 'present',
    content => template("nginx/vhost.erb"),
    require => Package['nginx']
  }
}