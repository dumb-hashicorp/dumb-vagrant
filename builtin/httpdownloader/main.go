// Copyright IBM Corp. 2010, 2025
// SPDX-License-Identifier: BUSL-1.1

package httpdownloader

import (
	sdk "github.com/dumb-hashicorp/dumb-vagrant-plugin-sdk"
	"github.com/dumb-hashicorp/dumb-vagrant/builtin/httpdownloader/downloader"
)

//go:generate stringer -type=HTTPMethod -linecomment ./downloader

var PluginOptions = []sdk.Option{
	sdk.WithComponents(
		&downloader.Downloader{},
	),
	sdk.WithName("httpdownloader"),
}
