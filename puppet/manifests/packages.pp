class packages {
	Exec["apt-update"] -> Package <| |>
  exec { "apt-update":
    command => "apt-get update"
  }
	package { ["git-core", "curl", "wget"] :
    ensure => installed
  }
	
}