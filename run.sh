#!/bin/bash
set -x
SCRIPTROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
mkdir -p build/python/lib/python3.7/site-packages build/bin
BUILDDIR="$(cd $SCRIPTROOT/../build && pwd)"

if [[ -s $SCRIPTROOT/yum ]];then
  yum install $(cat yum) -y
  cd /tmp
  yumdownloader $(echo n | sudo yum install $(cat $SCRIPTROOT/yum) | grep "will be installed" | cut -d " " -f 3 | paste -sd " ")
  rpmdev-extract *rpm
  mkdir -p $BUILDDIR/bin $BUILDDIR/lib64
  cd $BUILDDIR/lib64
  cp -R /tmp/*/usr/lib64/* .
  cd $BUILDDIR/bin
  cp $(find /tmp/*/usr/libexec -type f) .
fi

PATHS_ARRAY=($BUILDDIR/lib64/*/bin)
export PATH=$PATH:$(echo ${PATHS_ARRAY[@]}: | tr " " :)
if [[ -s $SCRIPTROOT/pip ]];then
  cd $BUILDDIR
  pip3.7 install -r $SCRIPTROOT/pip -t python/lib/python3.7/site-packages
#  zip -r $SCRIPTROOT/pip.zip .
fi

cd $BUILDDIR
chmod 755 -R .
zip -r $SCRIPTROOT/package.zip .
