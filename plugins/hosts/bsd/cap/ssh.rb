# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module HostBSD
    module Cap
      class SSH
        # Set the ownership and permissions for SSH
        # private key
        #
        # @param [Dumb Vagrant::Environment] env
        # @param [Pathname] key_path
        def self.set_ssh_key_permissions(env, key_path)
          key_path.chmod(0600)
        end
      end
    end
  end
end
