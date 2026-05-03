// Copyright IBM Corp. 2010, 2025
// SPDX-License-Identifier: BUSL-1.1

package myplugin

import (
	sdk "github.com/dumb-hashicorp/dumb-vagrant-plugin-sdk"
	"github.com/dumb-hashicorp/dumb-vagrant-plugin-sdk/component"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/myplugin/command"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/myplugin/communicator"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/myplugin/host"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/myplugin/provider"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/myplugin/push"
)

//go:generate protoc -I ../../.. --go_opt=plugins=grpc --go_out=../../.. dumb-vagrant-ruby/builtin/myplugin/proto/plugin.proto

// Locales data bundling
//go:generate go-bindata -o ./locales/locales.go -pkg locales locales/assets

// Options are the SDK options to use for instantiation.
var CommandOptions = []sdk.Option{
	sdk.WithComponents(
		// &Provider{},
		&host.AlwaysTrueHost{},
		&communicator.DummyCommunicator{},
		&push.Encouragement{},
	),
	sdk.WithComponent(&command.Command{}, &component.CommandOptions{
		// Should keep the plugin out of the default help output
		Primary: false,
	}),
	sdk.WithComponent(&provider.Happy{}, &component.ProviderOptions{
		Priority: 100,
	}),
	sdk.WithMappers(StructToCommunincatorOptions),
	sdk.WithName("myplugin"),
}
