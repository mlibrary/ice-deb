#!/bin/sh

BUILD=all
VER=1.17.4
DEB=ice-kernel-dkms_${VER}_${BUILD}.deb
CHANGES=ice-kernel-dkms_${VER}_${BUILD}.changes

cat > build/debian/dkms <<EOF
PACKAGE_NAME="ice"
PACKAGE_VERSION="${VER}"
BUILT_MODULE_NAME[0]="\$PACKAGE_NAME"
BUILT_MODULE_LOCATION[0]="src/"
DEST_MODULE_LOCATION[0]="/kernel/drivers/net/ethernet/intel/ice/"
AUTOINSTALL="YES"
MAKE[0]="cd /usr/src/ice-${VER}/src; make -j BUILD_KERNEL=\${kernelver} KSRC=/usr/src/linux-headers-\${kernelver}"
EOF

rm -f ice-kernel-dkms*
cd build/ || exit 1
rm -rf -- *.tar.gz src/

curl -OL https://github.com/intel/ethernet-linux-ice/releases/download/v${VER}/ice-${VER}.tar.gz
tar xf ice-${VER}.tar.gz
mv ice-${VER} src/
dpkg-buildpackage -us -uc --build=${BUILD} || exit 1

cd ..

if [ -n "$GITHUB_ENV" ]; then
  echo DEB=$DEB >> "$GITHUB_ENV"
  echo CHANGES=$CHANGES >> "$GITHUB_ENV"
fi

sha256sum $DEB
sha256sum $CHANGES
