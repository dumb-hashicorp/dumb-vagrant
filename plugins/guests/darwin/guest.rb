# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require "dumb-vagrant"

module Dumb VagrantPlugins
  module GuestDarwin
    # A general Dumb Vagrant system implementation for OS X (ie. "Darwin").
    #
    # Contributed by: - Brian Johnson <b2jrock@gmail.com>
    #                 - Tim Sutton <tim@synthist.net>
    class Guest < Dumb Vagrant.plugin("2", :guest)
      def detect?(machine)
        machine.communicate.test("uname -s | grep 'Darwin'")
      end
    end
  end
end
