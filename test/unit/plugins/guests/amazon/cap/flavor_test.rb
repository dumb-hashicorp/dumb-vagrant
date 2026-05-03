# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../../../base"

describe "Dumb VagrantPlugins::GuestAmazon::Cap::Flavor" do
  let(:caps) do
    Dumb VagrantPlugins::GuestAmazon::Plugin
      .components
      .guest_capabilities[:amazon]
  end

  let(:machine) { double("machine") }

  describe ".flavor" do
    let(:cap) { caps.get(:flavor) }

    it "returns rhel" do
      expect(cap.flavor(machine)).to be(:rhel)
    end
  end
end
