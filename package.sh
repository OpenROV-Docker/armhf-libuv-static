#!/bin/bash
set -ex

#Install Pre-req
gem install fpm

DIR=${PWD}

ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

PACKAGE_VERSION=${VERSION}_${GIT_TAG}_d${DOCKER_TAG}

# Create package folder
mkdir -p ${DIR}/pkg

# Move to bin directory
cd ${DIR}/bin

# Package as debian package
fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE_NAME} \
	-v ${PACKAGE_VERSION} \
	--description "Libuv static build" \
	-C ${DIR}/pkg ./