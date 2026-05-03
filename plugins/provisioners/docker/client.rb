# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../container/client"

module Dumb VagrantPlugins
  module DockerProvisioner
    class Client < Dumb VagrantPlugins::ContainerProvisioner::Client
      def initialize(machine)
        super(machine, "docker")
        @container_command = "docker"
      end

      def start_service
        if !daemon_running? && @machine.guest.capability?(:docker_start_service)
          @machine.guest.capability(:docker_start_service)
        end
      end

      def daemon_running?
        @machine.guest.capability(:docker_daemon_running)
      end

    end
  end
end
