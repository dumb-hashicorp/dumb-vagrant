# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module GuestPld
    module Cap
      class Flavor
        def self.flavor(machine)
          return :pld
        end
      end
    end
  end
end
