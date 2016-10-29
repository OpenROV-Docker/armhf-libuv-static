#!/bin/sh
set -ex

DIR=${PWD}
                                                                                                                                                                                                                         
mkdir -p /opt/workspace                                                                                                                                                                                                  
cd /opt/workspace                                                                                                                                                                                                        
                                                                                                                                                                                                                         
################################################                                                                                                                                                                         
# Generic git clone script                                                                                                                                                                                               
# inputs: PACKAGE_NAME, BRANCH, REPO, TAG                                                                                                                                                                                
                                                                                                                                                                                                                         
# Clone step                                                                                                                                                                                                             
git clone -b ${GIT_BRANCH} ${GIT_REPO} ${PACKAGE_NAME}                                                                                                                                                                           
cd ${PACKAGE_NAME}                                                                                                                                                                                                       
git checkout ${GIT_TAG}                                                                                                                                                                                                      
                                                                                                                                                                                                                         
################################################                                                                                                                                                                         
# Project specific build script                                                                                                                                                                                          
                                                                                                                                                                                                                         
# Install dependencies
apt-get update && \
apt-get install -y nano build-essential libtool autotools-dev autoconf

# Configure
./autogen.sh
./configure --enable-static --disable-shared --prefix=/usr/

# Build
make -j

# Create bin dir
mkdir -p ${DIR}/bin

# Install to out-of-source bin directory
make install DESTDIR=${DIR}/bin