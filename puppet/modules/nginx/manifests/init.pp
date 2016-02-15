class nginx {
	exec { 'apt-get update':
		command => '/usr/bin/apt-get update',
	}
	package { 'nginx':
		ensure => present,
	        require => Exec['apt-get update'],
	}
	file { 'lb-nginx':
		path => '/etc/nginx/sites-available/lb',
	        ensure => file,
	        require => Package['nginx'],
	        source => 'puppet:///modules/nginx/lb',
		notify => Service['nginx'],
	}
	file { 'default-nginx-disable':
	        path => '/etc/nginx/sites-enabled/default',
	        ensure => absent,
	        require => Package['nginx'],
	}
	file { 'lb-nginx-enable':
	        path => '/etc/nginx/sites-enabled/lb',
	        target => '/etc/nginx/sites-available/lb',
	        ensure => link,
	        notify => Service['nginx'],
	        require => [
			File['lb-nginx'],
		        File['default-nginx-disable'],
       		],
	}
        service { 'nginx':
                ensure => running,
                require => Package['nginx'],
        }

}
