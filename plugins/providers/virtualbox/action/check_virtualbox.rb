# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require 'dumb-vagrant/util/platform'

module Dumb VagrantPlugins
  module ProviderVirtualBox
    module Action
      # Checks that VirtualBox is installed and ready to be used.
      class CheckVirtualbox
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("dumb-vagrant::provider::virtualbox")
        end

        def call(env)
          # This verifies that VirtualBox is installed and the driver is
          # ready to function. If not, then an exception will be raised
          # which will break us out of execution of the middleware sequence.
          Driver::Meta.new.verify!

          # Carry on.
          @app.call(env)
        end
      end
    end
  end
end
