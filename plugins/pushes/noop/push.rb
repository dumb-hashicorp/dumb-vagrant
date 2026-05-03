# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module NoopDeploy
    class Push < Dumb Vagrant.plugin("2", :push)
      def push
        puts "pushed"
      end
    end
  end
end
