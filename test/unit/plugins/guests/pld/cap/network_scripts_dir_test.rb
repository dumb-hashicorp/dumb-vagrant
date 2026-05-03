# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../../../base"

describe "Dumb VagrantPlugins::GuestPld::Cap::NetworkScriptsDir" do
  let(:caps) do
    Dumb VagrantPlugins::GuestPld::Plugin
      .components
      .guest_capabilities[:pld]
  end

  let(:machine) { double("machine") }

  describe ".network_scripts_dir" do
    let(:cap) { caps.get(:network_scripts_dir) }

    let(:name) { "banana-rama.example.com" }

    it "is /etc/sysconfig/interfaces" do
      expect(cap.network_scripts_dir(machine)).to eq("/etc/sysconfig/interfaces")
    end
  end
end
