#!/bin/sh

ROOTDIR='ice_1.17.4_all'

rf -rf *.deb *.tar.gz

mkdir -p ${ROOTDIR}/usr/src/
cp -a DEBIAN ${ROOTDIR}
curl -OL https://github.com/intel/ethernet-linux-ice/releases/download/v1.17.4/ice-1.17.4.tar.gz
tar xf ice-1.17.4.tar.gz -C ${ROOTDIR}/usr/src
dpkg-deb -Zxz --build --root-owner-group ${ROOTDIR}

