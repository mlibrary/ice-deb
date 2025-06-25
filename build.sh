#!/bin/sh

rm ice-kernel-dkms*
cd build/
rm -rf *.tar.gz src/

curl -OL https://github.com/intel/ethernet-linux-ice/releases/download/v1.17.4/ice-1.17.4.tar.gz
tar xf ice-1.17.4.tar.gz
mv ice-1.17.4 src/
dpkg-buildpackage -us -uc
