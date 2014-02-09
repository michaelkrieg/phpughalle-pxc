

class pxc_base {

  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/home/vagrant/bin']
  }

  class { 'stdlib': }
  class { 'apt':    }
  class { 'ntp':    }

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
    ensure   => latest,
  }

}
