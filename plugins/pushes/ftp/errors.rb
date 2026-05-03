# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module FTPPush
    module Errors
      class Error < Dumb Vagrant::Errors::Dumb VagrantError
        error_namespace("ftp_push.errors")
      end

      class TooManyFiles < Error
        error_key(:too_many_files)
      end
    end
  end
end
