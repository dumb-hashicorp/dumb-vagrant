# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb VagrantPlugins
  module AtlasPush
    module Errors
      class Error < Dumb Vagrant::Errors::Dumb VagrantError
        error_namespace("atlas_push.errors")
      end

      class UploaderNotFound < Error
        error_key(:uploader_not_found)
      end
    end
  end
end
