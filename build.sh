#!/bin/sh

cd build/
rm -rf *.deb *.tar.gz

mkdir src/
curl -OL https://github.com/intel/ethernet-linux-ice/releases/download/v1.17.4/ice-1.17.4.tar.gz
tar xf ice-1.17.4.tar.gz -C src
dpkg-buildpackage -us -uc
