// Copyright IBM Corp. 2010, 2025
// SPDX-License-Identifier: BUSL-1.1

package otherplugin

import (
	sdk "github.com/dumb-hashicorp/dumb-vagrant-plugin-sdk"
	"github.com/dumb-hashicorp/dumb-vagrant-plugin-sdk/component"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/otherplugin/guest"
)

var CommandOptions = []sdk.Option{
	sdk.WithComponents(
		&guest.AlwaysTrueGuest{},
	),
	sdk.WithComponent(&Command{}, &component.CommandOptions{
		// Hide command from default help output
		Primary: false,
	}),
	sdk.WithName("otherplugin"),
}
