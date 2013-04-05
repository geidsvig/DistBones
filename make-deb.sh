#!/bin/bash

PRODUCT=geidsvig
PROJECT=distbones

# Requires "sbt dist" to have been run already.
if [ ! -e target/$PROJECT-dist ]; then
  echo "Fail. Run 'sbt dist' before creating the debian package"
  exit 0
fi

# Supports Jenkins build number, and defaults to 'x' for local builds.
BUILD_NUMBER=$1
if [ -z $BUILD_NUMBER ]; then
  BUILD_NUMBER="x"
fi


rm -rf deb/usr
mkdir -p deb/usr/local/$PRODUCT
cp -R target/$PROJECT-dist deb/usr/local/$PRODUCT/$PROJECT
cp -R conf deb/usr/local/$PRODUCT/$PROJECT/conf

# Creates version off of project Version and Jenkins build number
version=$(awk '/val/ {if ($2 == "Version") print $4}' project/Build.scala | sed -e 's/\"//g').$BUILD_NUMBER
sed -e 's/Version:/Version\: '"$version"'/g' <deb/DEBIAN/proto-control >deb/DEBIAN/control

dpkg -b deb $PRODUCT-$PROJECT-$version.deb
