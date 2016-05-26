class nginx (
  $document_root  = '/var/www',
  ){

  $package = $osfamily ? {
    'RedHat'  => 'nginx',
    'Debian'  => 'nginx',
  }

  $owner = $osfamily ? {
    'RedHat'  => 'root',
    'Debian'  => 'root',
  }

  $group = $osfamily ? {
    'RedHat'  => 'root',
    'Debian'  => 'root',
  }
  
  $service_name = $osfamily ? {
    'RedHat'  => 'nginx',
    'Debian'  => 'nginx',
  }
  
  $service_run = $osfamily ? {
    'RedHat'  => 'nginx',
    'Debian'  => 'www-data',
  }
  
  # $document_root = $osfamily ? {
  #  'RedHat'  => '/var/www',
  #  'Debian'  => '/var/www',
  #  }
  
  $config_directory = $osfamily ? {
    'RedHat'  => '/etc/nginx/conf.d',
    'Debian'  => '/etc/nginx/conf.d',
  }
  
  $log_dir = $osfamily ? {
    'RedHat' => '/var/log/nginx/',
    'Debian' => '/var/log/nginx/',
  }
  
  File{
    owner   => $owner,
    group   => $group,
  }
  
  package {$package:
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
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    mode    => '0644',
    content  => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d':
    ensure => directory,
    mode => '0775',
  }

  service {$service_name:
    ensure => 'running',
    enable => 'true',
    subscribe => File['/etc/nginx/nginx.conf'],
  }

 }   
