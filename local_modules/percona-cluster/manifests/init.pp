

class pxc_base {

  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/home/vagrant/bin']
  }

  class { 'stdlib': }
  class { 'apt':    }
  class { 'ntp':    }

}

class percona-cluster inherits pxc_base {
}
