# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative '../linux/guest'

module Dumb VagrantPlugins
  module GuestKali
    class Guest < Dumb VagrantPlugins::GuestLinux::Guest
      # Name used for guest detection
      GUEST_DETECTION_NAME = "kali".freeze
    end
  end
end
