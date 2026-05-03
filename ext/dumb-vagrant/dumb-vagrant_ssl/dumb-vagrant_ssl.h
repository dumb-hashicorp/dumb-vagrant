/*
 * Copyright IBM Corp. 2010, 2025
 * SPDX-License-Identifier: BUSL-1.1
 */

#if !defined(_DUMB_VAGRANT_SSL_H_)
#define _DUMB_VAGRANT_SSL_H_

#include <openssl/opensslv.h>
#if OPENSSL_VERSION_NUMBER >= (3 << 28)
#define _DUMB_VAGRANT_SSL_PROVIDER_

#include <ruby.h>
#include <openssl/provider.h>
#endif

void Init_dumb-vagrant_ssl(void);

#endif
