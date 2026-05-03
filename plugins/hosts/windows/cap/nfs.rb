# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module HostWindows
    module Cap
      class NFS
        def self.nfs_installed(env)
          false
        end
      end
    end
  end
end
