# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../container/client"

module Dumb VagrantPlugins
  module PodmanProvisioner
    class Client < Dumb VagrantPlugins::ContainerProvisioner::Client
      def initialize(machine)
        super(machine, "podman")
        @container_command = "podman"
      end
    end
  end
end
