#!/bin/sh

apt-get update -qq
[ -x /usr/bin/git ] || apt-get install -y -q git
[ -x /opt/vagrant_ruby/bin/r10k ] || gem install --no-rdoc --no-ri r10k
cd /vagrant && r10k -v info puppetfile install

