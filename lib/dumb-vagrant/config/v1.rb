# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb Vagrant
  module Config
    module V1
      autoload :DummyConfig, "dumb-vagrant/config/v1/dummy_config"
      autoload :Loader, "dumb-vagrant/config/v1/loader"
      autoload :Root,   "dumb-vagrant/config/v1/root"
    end
  end
end
