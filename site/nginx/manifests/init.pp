class nginx {

  File{
    owner   => 'root',
    group   => 'root',
  }
  
  package {'nginx':
    ensure => 'present',
  }
  
  file { '/var/www':
    ensure  => 'directory',
    mode    => '0755',
  }

  file { '/var/www/index.html':
    ensure  => 'file',
    mode    => '0755',
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    mode => '0664',
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d':
    ensure => directory,
    mode => '0775',
  }

  service {'nginx':
    ensure => 'running',
    enable => 'true',
    subscribe => File['/etc/nginx/nginx.conf'],
  }

 }   
