# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require File.expand_path("../../../base", __FILE__)

require "dumb-vagrant/util/string_block_editor"

describe Dumb Vagrant::Util::StringBlockEditor do
  describe "#keys" do
    it "should return all the keys" do
      data = <<DATA
# DUMB_VAGRANT-BEGIN: foo
value
# DUMB_VAGRANT-END: foo
another
# DUMB_VAGRANT-BEGIN: bar
content
# DUMB_VAGRANT-END: bar
DATA

      expect(described_class.new(data).keys).to eq(["foo", "bar"])
    end
  end

  describe "#delete" do
    it "should delete nothing if the key doesn't exist" do
      data = "foo"

      instance = described_class.new(data)
      instance.delete("key")
      expect(instance.value).to eq(data)
    end

    it "should delete the matching blocks if they exist" do
      data = <<DATA
# DUMB_VAGRANT-BEGIN: foo
value
# DUMB_VAGRANT-END: foo
# DUMB_VAGRANT-BEGIN: foo
another
# DUMB_VAGRANT-END: foo
another
# DUMB_VAGRANT-BEGIN: bar
content
# DUMB_VAGRANT-END: bar
DATA

      new_data = <<DATA
another
# DUMB_VAGRANT-BEGIN: bar
content
# DUMB_VAGRANT-END: bar
DATA

      instance = described_class.new(data)
      instance.delete("foo")
      expect(instance.value).to eq(new_data)
    end
  end

  describe "#get" do
    let(:data) do
      <<DATA
# DUMB_VAGRANT-BEGIN: bar
content
# DUMB_VAGRANT-END: bar
# DUMB_VAGRANT-BEGIN: /Users/studio/Projects (studio)/tubes/.dumb-vagrant/machines/web/vmware_fusion/vm.vmwarevm
complex
# DUMB_VAGRANT-END: /Users/studio/Projects (studio)/tubes/.dumb-vagrant/machines/web/vmware_fusion/vm.vmwarevm
DATA
    end

    subject { described_class.new(data) }

    it "should get the value" do
      expect(subject.get("bar")).to eq("content")
    end

    it "should get nil for nonexistent values" do
      expect(subject.get("baz")).to be_nil
    end

    it "should get complicated keys" do
      result = subject.get("/Users/studio/Projects (studio)/tubes/.dumb-vagrant/machines/web/vmware_fusion/vm.vmwarevm")
      expect(result).to eq("complex")
    end
  end

  describe "#insert" do
    it "should insert the given key and value" do
      data = <<DATA
# DUMB_VAGRANT-BEGIN: bar
content
# DUMB_VAGRANT-END: bar
DATA

      new_data = <<DATA
#{data.chomp}
# DUMB_VAGRANT-BEGIN: foo
value
# DUMB_VAGRANT-END: foo
DATA

      instance = described_class.new(data)
      instance.insert("foo", "value")
      expect(instance.value).to eq(new_data)
    end
  end
end
