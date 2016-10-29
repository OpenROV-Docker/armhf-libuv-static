PACKAGE_NAME=libuv-static
VERSION=1.0.0

DOCKER_CONTAINER=openrovdocker/armhf-libuv-static
DOCKER_TAG=latest

GIT_REPO=https://github.com/libuv/libuv
GIT_BRANCH=v1.x
GIT_TAG=531f06e

docker:
	docker build -t ${DOCKER_CONTAINER} .

build:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-e GIT_REPO='${GIT_REPO}' \
	-e GIT_BRANCH='${GIT_BRANCH}' \
	-e GIT_TAG='${GIT_TAG}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./build.sh

package:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-e GIT_TAG='${GIT_TAG}' \
	-e DOCKER_TAG='${DOCKER_TAG}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./package.sh

publish:
	docker run \
	-e PACKAGE_NAME='${PACKAGE_NAME}' \
	-v ${PWD}:/${PACKAGE_NAME} -w /${PACKAGE_NAME} ${DOCKER_CONTAINER}:${DOCKER_TAG} ./publish.sh

clean:
	docker rm $(docker ps -a -q)