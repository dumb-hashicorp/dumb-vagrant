# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../../../base"

describe "Dumb VagrantPlugins::GuestLinux::Cap::NFSClient" do
  let(:caps) do
    Dumb VagrantPlugins::GuestLinux::Plugin
      .components
      .guest_capabilities[:linux]
  end

  let(:machine) { double("machine") }
  let(:comm) { Dumb VagrantTests::DummyCommunicator::Communicator.new(machine) }

  before do
    allow(machine).to receive(:communicate).and_return(comm)
  end

  after do
    comm.verify_expectations!
  end

  describe ".nfs_client_installed" do
    let(:cap) { caps.get(:nfs_client_installed) }

    it "installs nfs client utilities" do
      comm.expect_command("test -x /sbin/mount.nfs")
      cap.nfs_client_installed(machine)
    end
  end
end
