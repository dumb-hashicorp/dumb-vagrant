# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require File.expand_path("../../../base", __FILE__)

require "dumb-vagrant/util/shell_quote"

describe Dumb Vagrant::Util::ShellQuote do
  subject { described_class }

  it "quotes properly" do
    expected = "foo '\\''bar'\\''"
    expect(subject.escape("foo 'bar'", "'")).to eql(expected)
  end
end
