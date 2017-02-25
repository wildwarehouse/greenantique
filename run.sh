#!/bin/sh
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

dnf update --assumeyes &&
    dnf install --assumeyes git &&
    dnf install --assumeyes firefox &&
    dnf install --assumeyes bash &&
    dnf install --assumeyes emacs* &&
    dnf install --assumeyes meld &&
    dnf install --assumeyes curl &&
    dnf install --assumeyes sudo &&
    dnf install --assumeyes gnome-terminal &&
    cp /opt/docker/docker.repo /etc/yum.repos.d &&
    dnf update --assumeyes &&
    dnf install --assumeyes docker-engine &&
    adduser user &&
    cp /opt/docker/user.sudo /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    mkdir /home/user/.ssh &&
    chmod 0700 /home/user/.ssh &&
    cp /opt/docker/config /home/user/.ssh &&
    chmod 0600 /home/user/.ssh/config &&
    cp /opt/docker/known_hosts /home/user/.ssh &&
    chmod 0644 /home/user/.ssh/known_hosts &&
    chown --recursive user:user /home/user/.ssh &&
    git -C /usr/local/src init &&
    cp /opt/docker/post-commit.sh /usr/local/src/.git/hooks/post-commit &&
    chmod 0500 /usr/local/src/.git/hooks/post-commit &&
    cp /opt/docker/git-flex.sh /usr/local/bin/git-flex &&
    chmod 0555 /usr/local/bin/git-flex &&
    cp /opt/docker/git-flex-scratch.sh /usr/local/bin/git-flex-scratch &&
    chmod 0555 /usr/local/bin/git-flex-scratch &&
    chown --recursive user:user /usr/local/src &&
    dnf update --assumeyes &&
    dnf clean all
