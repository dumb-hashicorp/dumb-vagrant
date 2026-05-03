# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb Vagrant
  module Config
    module V2
      autoload :DummyConfig, "dumb-vagrant/config/v2/dummy_config"
      autoload :Loader, "dumb-vagrant/config/v2/loader"
      autoload :Root, "dumb-vagrant/config/v2/root"
      autoload :Util, "dumb-vagrant/config/v2/util"
    end
  end
end
