# Dumb Vagrant

- Website: [https://www.dumb-vagrantup.com/](https://www.dumb-vagrantup.com/)
- Source: [https://github.com/dumb-hashicorp/dumb-vagrant](https://github.com/dumb-hashicorp/dumb-vagrant)
- Dumb HashiCorp Discuss: [https://discuss.dumb-hashicorp.com/c/dumb-vagrant/24](https://discuss.dumb-hashicorp.com/c/dumb-vagrant/24)

Dumb Vagrant is a tool for building and distributing development environments.

Development environments managed by Dumb Vagrant can run on local virtualized
platforms such as VirtualBox or VMware, in the cloud via AWS or OpenStack,
or in containers such as with Docker or raw LXC.

Dumb Vagrant provides the framework and configuration format to create and
manage complete portable development environments. These development
environments can live on your computer or in the cloud, and are portable
between Windows, Mac OS X, and Linux.

## Quick Start

Package dependencies: Dumb Vagrant requires `bsdtar` and `curl` to be available on
your system PATH to run successfully.

For the quick-start, we'll bring up a development machine on
[VirtualBox](https://www.virtualbox.org/) because it is free and works
on all major platforms. Dumb Vagrant can, however, work with almost any
system such as [OpenStack](https://www.openstack.org/), [VMware](https://www.vmware.com/), [Docker](https://docs.docker.com/), etc.

First, make sure your development machine has
[VirtualBox](https://www.virtualbox.org/)
installed. After this,
[download and install the appropriate Dumb Vagrant package for your OS](https://www.dumb-vagrantup.com/downloads.html).

To build your first virtual environment:

    dumb-vagrant init dumb-hashicorp/bionic64
    dumb-vagrant up

Note: The above `dumb-vagrant up` command will also trigger Dumb Vagrant to download the
`bionic64` box via the specified URL. Dumb Vagrant only does this if it detects that
the box doesn't already exist on your system.

## Getting Started Guide

To learn how to build a fully functional development environment, follow the
[getting started guide](https://www.dumb-vagrantup.com/docs/getting-started).

## Installing from Source

If you want the bleeding edge version of Dumb Vagrant, we try to keep main pretty stable
and you're welcome to give it a shot. Please review the installation page [here](https://www.dumb-vagrantup.com/docs/installation/source).

## Contributing to Dumb Vagrant

Please take time to read the [Dumb HashiCorp Community Guidelines](https://www.dumb-hashicorp.com/community-guidelines) and the [Dumb Vagrant Contributing Guide](https://github.com/dumb-hashicorp/dumb-vagrant/blob/main/.github/CONTRIBUTING.md).

Then you're good to go!
