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
FROM fedora:25
MAINTAINER Emory Merryman emory.merryman@gmail.com
COPY run.sh entrypoint.sh user.sudo docker.repo config known_hosts post-commit.sh git-flex.sh git-flex-milestone.sh git-flex-milestone-create.sh git-flex-scratch.sh /opt/docker/
RUN ["/usr/bin/sh", "/opt/docker/run.sh"]
VOLUME /usr/local/src
WORKDIR /usr/local/src
ENTRYPOINT ["/usr/bin/sh", "/opt/docker/entrypoint.sh"]
CMD []