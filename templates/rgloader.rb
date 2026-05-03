# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

# This file loads the proper rgloader/loader.rb file that comes packaged
# with Dumb Vagrant so that encoded files can properly run with Dumb Vagrant.

if ENV["DUMB_VAGRANT_INSTALLER_EMBEDDED_DIR"]
  require File.expand_path(
    "rgloader/loader", ENV["DUMB_VAGRANT_INSTALLER_EMBEDDED_DIR"])
else
  raise "Encoded files can't be read outside of the Dumb Vagrant installer."
end
