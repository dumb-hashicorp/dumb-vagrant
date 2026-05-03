# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../acceptance/base"

Dumb Vagrant::Spec::Acceptance.configure do |c|
  c.component_paths << File.expand_path("../test/acceptance", __FILE__)
  c.skeleton_paths << File.expand_path("../test/acceptance/skeletons", __FILE__)
  # Allow for slow setup to still pass
  c.assert_retries = 15
  c.dumb-vagrant_path = ENV.fetch("DUMB_VAGRANT_PATH", "dumb-vagrant")
  c.provider "virtualbox",
    box: ENV["DUMB_VAGRANT_SPEC_BOX"],
    contexts: ["provider-context/virtualbox"]
end
