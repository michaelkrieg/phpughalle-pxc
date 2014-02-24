

class pxc_base {

  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/home/vagrant/bin']
  }

  class { 'stdlib':                   }
  class { 'apt::backports':           }
  class { 'ntp':                      }

  host { 'pxc1.pxc.cluster.local':
    ip => '172.23.77.11',
    host_aliases => 'pxc1',
  }
  host { 'pxc2.pxc.cluster.local':
    ip => '172.23.77.12',
    host_aliases => 'pxc2',
  }
  host { 'pxc3.pxc.cluster.local':
    ip => '172.23.77.13',
    host_aliases => 'pxc3',
  }
  
}

class percona-cluster inherits pxc_base {

  apt::source { "percona":
    key               => "1C4CBDCDCD2EFD2A",
    location          => "http://repo.percona.com/apt",
    release           => "wheezy",
    repos             => "main",
    required_packages => "debian-keyring debian-archive-keyring",
    include_src       => true
  } ->
  package {'percona-xtradb-cluster-56':
    ensure  => latest,
  } ->
  service { 'mysql':
    ensure  => 'stopped',
    require => Package['percona-xtradb-cluster-56'],
  } ->
  file { "/etc/mysql/my.cnf":
    ensure => 'present',
    source => "puppet:///modules/percona-cluster/my.cnf",
  } ->
  file { "/etc/mysql/conf.d/${hostname}-cluster.cnf":
    ensure => 'present',
    source => "puppet:///modules/percona-cluster/${hostname}-my-cluster.cnf",
  } ->
  file { "/root/bootstrap-pxc.sh":
    ensure => 'present',
    mode   => '0750',
    source => "puppet:///modules/percona-cluster/bootstrap-pxc.sh",
  } ->
  class { 'percona-cluster::haproxy': }
  
}
