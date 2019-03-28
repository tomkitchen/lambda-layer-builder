#!/bin/bash
SCRIPTROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BUILDDIR="$(cd $SCRIPTROOT/../build && pwd)"

if [[ -s $SCRIPTROOT/pip ]];then
  cd $BUILDDIR/pip
  pip3.7 install -r $SCRIPTROOT/pip -t python/lib/python3.7/site-packages
  zip -r $SCRIPTROOT/pip.zip .
fi

if [[ -s $SCRIPTROOT/yum ]];then
  cd /tmp
  yumdownloader $(echo n | sudo yum install $(cat $SCRIPTROOT/yum) | grep "will be installed" | cut -d " " -f 3 | paste -sd " ")
  rpmdev-extract *rpm

  cd $BUILDDIR/yum
  cp -R /tmp/*/usr/lib64/* .
  zip -r $SCRIPTROOT/yum.zip .
fi
