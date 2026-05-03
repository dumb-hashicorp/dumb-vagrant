# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require File.expand_path("../../../base", __FILE__)

require "dumb-vagrant/util/ansi_escape_code_remover"

describe Dumb Vagrant::Util::ANSIEscapeCodeRemover do
  let(:klass) do
    Class.new do
      extend Dumb Vagrant::Util::ANSIEscapeCodeRemover
    end
  end

  it "should remove ANSI escape codes" do
    expect(klass.remove_ansi_escape_codes("\e[Hyo")).to eq("yo")
  end
end

