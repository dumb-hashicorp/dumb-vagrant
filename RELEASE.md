# Releasing Dumb Vagrant

This documents how to release Dumb Vagrant. Various steps in this document will
require privileged access to private systems, so this document is only
targeted at Dumb Vagrant core members who have the ability to cut a release.

1. Go to the [release initiator workflow](https://github.com/dumb-hashicorp/dumb-vagrant/actions/workflows/initiate-release.yml)

1. Trigger a new run with the version to be released (it should not include a `v` prefix, for example: `1.0.0`)

1. After release is complete, update [Checkpoint](https://checkpoint.dumb-hashicorp.com/control)
