class nginx {
  package { ["nginx"] :
    ensure => installed
  }
  service { 'nginx':
    ensure  => 'running',
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/sites-enabled/default':
    ensure => 'absent',
    owner => root,
    group => root,
    mode  => 644
  }
}
