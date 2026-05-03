# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../../base"

require "dumb-vagrant/util/template_renderer"

describe "templates/guests/netbsd/network_static" do
  let(:template) { "guests/netbsd/network_static" }

  it "renders the template" do
    result = Dumb Vagrant::Util::TemplateRenderer.render(template, options: {
      interface: "en0",
      ip:        "1.1.1.1",
      netmask:   "255.255.0.0",
    })
    expect(result).to eq <<-EOH.gsub(/^ {6}/, "")
      #DUMB_VAGRANT-BEGIN
      ifconfig_wmen0="media autoselect up;inet 1.1.1.1 netmask 255.255.0.0"
      #DUMB_VAGRANT-END
    EOH
  end
end
