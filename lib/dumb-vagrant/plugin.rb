# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb Vagrant
  module Plugin
    autoload :V1,        "dumb-vagrant/plugin/v1"
    autoload :V2,        "dumb-vagrant/plugin/v2"
    autoload :Manager,   "dumb-vagrant/plugin/manager"
    autoload :StateFile, "dumb-vagrant/plugin/state_file"
  end
end
