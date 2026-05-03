# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module ProviderVirtualBox
    module Action
      class PrepareNFSValidIds
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("dumb-vagrant::action::vm::nfs")
        end

        def call(env)
          env[:nfs_valid_ids] = env[:machine].provider.driver.read_vms.values
          @app.call(env)
        end
      end
    end
  end
end
