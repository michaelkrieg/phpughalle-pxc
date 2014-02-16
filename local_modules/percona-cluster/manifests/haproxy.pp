class percona-cluster::haproxy {
  package {'haproxy':
    ensure  => latest,
    require => Class['apt::backports'],
  } ->
  service { 'haproxy':
    ensure  => 'stopped',
    require => Package['haproxy'],
  }
}