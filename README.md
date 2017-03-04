<!--
# Copyright © (C) 2017 Emory Merryman <emory.merryman@gmail.com>
#   This file is part of greenantique.
#
#   greenantique is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   greenantique is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with greenantique.  If not, see <http://www.gnu.org/licenses/>.
-->

# greenantique

## Synopsis
This package sets up a development computer environment.

## Usage

```
export GITHUB_USER_ID &&
export GITHUB_TOKEN &&
export GIT_USER_EMAIL="some.one@some.domain" &&
export GIT_USER_NAME="Some One" &&
export IMAGE_TAG=2f94f206cea80192ad13f4c95303d8485c045d08 &&
CID=$(mktemp -d) &&
docker \
       run \
       --interactive \
       --tty \
       --rm \
       --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
       --env DISPLAY \
       --net host \
       --env GITHUB_USER_ID \
       --env GITHUB_TOKEN \
       --env GIT_USER_EMAIL \
       --env GIT_USER_NAME \
       --env GITHUB_UPSTREAM_ORGANIZATION=wildwarehouse \
       --env GITHUB_UPSTREAM_REPOSITORY=greenantique \
       --env GITHUB_ORIGIN_ORGANIZATION=wildwarehouse \
       --env GITHUB_ORIGIN_REPOSITORY=greenantique \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --cidfile ${CID}/cid \
       --volume ${CID}:/opt/docker/run/cid \
       --user user \
       wildwarehouse/greenantique:${IMAGE_TAG}
```