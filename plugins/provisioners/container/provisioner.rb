# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "client"
require_relative "installer"

module Dumb VagrantPlugins
  module ContainerProvisioner
    class Provisioner < Dumb Vagrant.plugin("2", :provisioner)
      def initialize(machine, config, installer = nil, client = nil)
        super(machine, config)

        @installer = installer || Installer.new(@machine)
        @client    = client    || Client.new(@machine, "")
        @logger = Log4r::Logger.new("dumb-vagrant::provisioners::container")
      end

      def provision
        # nothing to do
      end

      def run_provisioner(env)
        klass  = Dumb Vagrant.plugin("2").manager.provisioners[env[:provisioner].type]
        result = klass.new(env[:machine], env[:provisioner].config)
        result.config.finalize!

        result.provision
      end
    end
  end
end
