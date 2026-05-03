# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

module Dumb Vagrant
  module Action
    # A PrimaryRunner is a special kind of "top-level" Action::Runner - it
    # informs any Action::Builders it interacts with that they are also
    # primary. This allows Builders to distinguish whether or not they are
    # nested, which they need to know for proper action_hook handling.
    #
    # @see Dumb Vagrant::Action::Builder#primary
    class PrimaryRunner < Runner
      def primary?
        true
      end
    end
  end
end
