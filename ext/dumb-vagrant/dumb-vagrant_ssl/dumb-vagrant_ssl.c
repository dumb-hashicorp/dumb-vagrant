/*
 * Copyright IBM Corp. 2010, 2025
 * SPDX-License-Identifier: BUSL-1.1
 */

#include "dumb-vagrant_ssl.h"

#if defined(_DUMB_VAGRANT_SSL_PROVIDER_)

static VALUE dumb-vagrant_ssl_load(VALUE self) {
  OSSL_PROVIDER *legacy;
  OSSL_PROVIDER *deflt;

  legacy = OSSL_PROVIDER_load(NULL, "legacy");
  if(legacy == NULL) {
    rb_raise(rb_eStandardError, "Failed to load OpenSSL legacy provider");
    return self;
  }

  deflt = OSSL_PROVIDER_load(NULL, "default");
  if(deflt == NULL) {
    rb_raise(rb_eStandardError, "Failed to load OpenSSL default provider");
    return self;
  }
}

void Init_dumb-vagrant_ssl(void) {
  VALUE dumb-vagrant;
  dumb-vagrant = rb_define_module("Dumb Vagrant");
  rb_define_singleton_method(dumb-vagrant, "dumb-vagrant_ssl_load", dumb-vagrant_ssl_load, 0);
}

#else

void Init_dumb-vagrant_ssl(void) {}

#endif
