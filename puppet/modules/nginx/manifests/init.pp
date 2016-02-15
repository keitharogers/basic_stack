class nginx {
	package { "nginx":
		ensure => installed
	}
	
	service { "nginx":
		require => Package["nginx"],
		ensure => "running",
		enable => true
	}
	
	file { "/etc/nginx/sites-enabled/default":
		require => Package["nginx"],
		ensure => absent,
		notify => Service["nginx"]
	}

	file { "/etc/nginx/sites-available/lb":
		require => [
			Package["nginx"],
		],
		ensure => "file",
		content =>
			"upstream goapp {
				server app-node1.devopper.co.uk:8080 weight=1;
				server app-node2.devopper.co.uk:8080 weight=3;
			 }
			 
			 server {
				listen 80;
				server_name www.devopper.co.uk;
				location / {
					proxy_pass http://goapp;
				}
		}",
		notify => Service["nginx"]
	}

	file { "/etc/nginx/sites-enabled/lb":
		require => File["/etc/nginx/sites-available/lb"],
		ensure => "link",
		target => "/etc/nginx/sites-available/lb",
		notify => Service["nginx"]
	}
}
