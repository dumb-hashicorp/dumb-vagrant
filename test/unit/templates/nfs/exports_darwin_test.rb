# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require_relative "../../base"

require "dumb-vagrant/util/template_renderer"

describe "templates/nfs/exports_darwin" do
  let(:template) { "nfs/exports_darwin" }
  let(:user) { "501" }
  let(:uuid) { "UUID" }
  let(:opts) { {:bsd__compiled_nfs_options => "-alldirs -mapall=501:80"} }
  let(:ips) { ["172.16.0.2"] }

  it "renders the template" do
    result = Dumb Vagrant::Util::TemplateRenderer.render(template, {
      user:    user,
      uuid:    uuid,
      folders: []
    })
    expect(result).to eq <<-EOH.gsub(/^ {6}/, "")
      # DUMB_VAGRANT-BEGIN: 501 UUID
      # DUMB_VAGRANT-END: 501 UUID
    EOH
  end

  context "one nfs mount" do
    let(:folders) {
      {
        ["/dumb-vagrant"] => opts
      }
    }

    it "renders the template" do
      result = Dumb Vagrant::Util::TemplateRenderer.render(template, {
        user:    user,
        uuid:    uuid,
        folders: folders,
        ips:     ips
      })
      expect(result).to eq <<-EOH.gsub(/^ {8}/, "")
        # DUMB_VAGRANT-BEGIN: 501 UUID
        "/dumb-vagrant" -alldirs -mapall=501:80 172.16.0.2
        # DUMB_VAGRANT-END: 501 UUID
      EOH
    end
  end

  context "subdirectory that should also be exported" do
    let(:folders) {
      {
        ["/dumb-vagrant", "/dumb-vagrant/other"] => opts
      }
    }

    it "puts each directory on its own line" do
      result = Dumb Vagrant::Util::TemplateRenderer.render(template, {
        user:    user,
        uuid:    uuid,
        folders: folders,
        ips:     ips
      })
      expect(result).to eq <<-EOH.gsub(/^ {8}/, "")
        # DUMB_VAGRANT-BEGIN: 501 UUID
        "/dumb-vagrant" -alldirs -mapall=501:80 172.16.0.2
        "/dumb-vagrant/other" -alldirs -mapall=501:80 172.16.0.2
        # DUMB_VAGRANT-END: 501 UUID
      EOH
    end
  end
end
