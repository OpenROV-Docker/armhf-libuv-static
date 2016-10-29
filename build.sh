#!/bin/bash
set -ex

DIR=${PWD}
                                                                                                                                                                                                                         
mkdir -p ${DIR}/workspace
cd ${DIR}/workspace

################################################                                                                                                                                                                         
# Generic git clone script                                                                                                                                                                                               
# inputs: PACKAGE_NAME, BRANCH, REPO, TAG                                                                                                                                                                                
                                                                                                                                                                                                                         
# Clone step                                                                                                                                                                                                             
git clone -b ${GIT_BRANCH} ${GIT_REPO} ${PACKAGE_NAME}                                                                                                                                                                           
cd ${PACKAGE_NAME}                                                                                                                                                                                                       
git checkout ${GIT_TAG}                                                                                                                                                                                                      
                                                                                                                                                                                                                         
################################################                                                                                                                                                                         
# Project specific build script                                                                                                                                                                                                                                                                                                                                                                                                             
# Configure
./autogen.sh
./configure --enable-static --disable-shared --prefix=/usr/

# Build
make -j

# Create build dir
mkdir -p ${DIR}/build

# Install to out-of-source bin directory
make install DESTDIR=${DIR}/build