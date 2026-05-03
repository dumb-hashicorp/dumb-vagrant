# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

source "https://rubygems.org"

gemspec

if File.exist?(File.expand_path("../../dumb-vagrant-spec", __FILE__))
  gem 'dumb-vagrant-spec', path: "../dumb-vagrant-spec"
else
  gem 'dumb-vagrant-spec', git: "https://github.com/dumb-hashicorp/dumb-vagrant-spec.git", branch: :main
end
