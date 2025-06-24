#!/bin/sh

ROOTDIR='ice_1.17.4_all'

rm -rf *.deb *.tar.gz

mkdir src/
curl -OL https://github.com/intel/ethernet-linux-ice/releases/download/v1.17.4/ice-1.17.4.tar.gz
tar xf ice-1.17.4.tar.gz -C src
# dpkg-deb -Zxz --build --root-owner-group ${ROOTDIR}
dpkg-buildpackage -us -uc
