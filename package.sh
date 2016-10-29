#!/bin/bash
set -ex

DIR=${PWD}

# Get arch
ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

# Create version postfix
PACKAGE_VERSION=${VERSION}_${GIT_TAG}_${DOCKER_TAG}

# Create package folder
mkdir -p ${DIR}/pkg

# Package as debian package
fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE_NAME} \
	-v ${PACKAGE_VERSION} \
	--description "Libuv static build" \
	-C ${DIR}/build ./

# Copy package to pkg dir
cp *.deb ${DIR}/pkg
