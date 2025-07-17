#!/bin/bash

set -x 

# remove tc.h

tc="#include \"tc.h\""
sed -i "s/$tc//" kern/gnutls.h
sed -i "s/$tc//" kern/openssl.h
sed -i "s/$tc//" kern/gotls_kern.c


# remove openssl_masterkey
openssl_master="#include \"openssl_masterkey.h\""
sed -i "s/$openssl_master//" kern/openssl_*


# remove gnutls_masterkey
gnutls_master="#include \"gnutls_masterkey.h\""
sed -i "s/$gnutls_master//" kern/gnutls_*


# remove gotls_masterkey
gnutls_master="#include \"gnutls_masterkey.h\""
sed -i "s/$gnutls_master//" kern/gnutls_*