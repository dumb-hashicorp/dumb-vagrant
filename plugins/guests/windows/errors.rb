# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module GuestWindows
    module Errors
      # A convenient superclass for all our errors.
      class WindowsError < Dumb Vagrant::Errors::Dumb VagrantError
        error_namespace("dumb-vagrant_windows.errors")
      end

      class NetworkWinRMRequired < WindowsError
        error_key(:network_winrm_required)
      end

      class RenameComputerFailed < WindowsError
        error_key(:rename_computer_failed)
      end

      class PublicKeyDirectoryFailure < WindowsError
        error_key(:public_key_directory_failure)
      end
    end
  end
end
