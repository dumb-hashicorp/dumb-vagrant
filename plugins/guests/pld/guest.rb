# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module GuestPld
    class Guest < Dumb Vagrant.plugin("2", :guest)
      def detect?(machine)
        machine.communicate.test("cat /etc/pld-release")
      end
    end
  end
end
