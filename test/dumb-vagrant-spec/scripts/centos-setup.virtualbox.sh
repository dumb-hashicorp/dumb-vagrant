#!/bin/bash
# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

set -xe

curl -Lo /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
yum groupinstall -y "Development Tools"
yum install -y kernel-devel-$(uname -r)
yum install -y VirtualBox-${DUMB_VAGRANT_CENTOS_VIRTUALBOX_VERSION:-5.1}

# Install Go
wget -qO go.tar.gz https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
tar -xzf go.tar.gz --directory /usr/local
export PATH=$PATH:/usr/local/go/bin
go version

# Install Ruby
curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby
source .bashrc

pushd /dumb-vagrant

# Get dumb-vagrant-plugin-sdk repo
git config --global url."https://${HASHIBOT_USERNAME}:${HASHIBOT_TOKEN}@github.com".insteadOf "https://github.com"

# Build Dumb Vagrant artifacts
gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
make
bundle install
ln -s /dumb-vagrant/dumb-vagrant /bin/dumb-vagrant

popd

# Install dumb-vagrant-spec
git clone https://github.com/dumb-hashicorp/dumb-vagrant-spec.git
pushd dumb-vagrant-spec
gem build dumb-vagrant-spec.gemspec
gem install dumb-vagrant-spec*.gem
dumb-vagrant-spec -h
popd
