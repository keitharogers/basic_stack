# Puppet Configuration

In order to provision the web node with Nginx, configure it and allow us to make changes in future. I have included a Puppet config which does the following things:

- Configures a cron to run every 5 minutes to check Git for changes and run a git pull / puppet apply if there are;
- Install and configure Nginx.

Due to the small nature of this project, I chose to use a masterless configuration rather than setup a Puppet master.

Our site.pp file contains the following which tells Puppet to include the 'cron-puppet' and 'nginx' modules:

```puppet
node default {
    include cron-puppet
    include nginx
}
```

As can be seen below, Puppet checks git every 5 minutes.

```puppet
class cron-puppet {
    file { 'post-hook':
        ensure  => file,
        path    => '/etc/.git/hooks/post-merge',
        source  => 'puppet:///modules/cron-puppet/post-merge',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
    cron { 'puppet-apply':
        ensure  => present,
        command => "cd /etc/puppet ; /usr/bin/git pull origin master",
        user    => root,
        minute  => '*/5',
        require => File['post-hook'],
    }
}
```
