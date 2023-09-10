# Manifest to configure an Ubuntu server with nginx
package { 'nginx':
  ensure   => present,
  provider => 'apt'
}
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!'
}
file_line { 'Redirection':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => '        rewrite ^/redirect_me https://www.github.com/ARTISTIC-BEAST permanent;'
}
service { 'nginx':
  ensure    => running,
  enable    => true,
  require   => Package['nginx'],
  subscribe => File_line['Redirection']
}
