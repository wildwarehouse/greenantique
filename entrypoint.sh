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

KEY_ID="$(uuidgen)" &&
    ssh-keygen -f /home/user/.ssh/id_rsa -P "" -C "${KEY_ID}" &&
    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"${KEY_ID}\", \"key\": \"$(cat /home/user/.ssh/id_rsa.pub)\"}" https://api.github.com/user/keys &&
    git config user.email "${GIT_USER_EMAIL}" &&
    git config user.name "${GIT_USER_NAME}" &&
    git remote add upstream upstream:${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY} &&
    git remote add origin origin:${GITHUB_ORIGIN_ORGANIZATION}/${GITHUB_ORIGIN_REPOSITORY} &&
    /usr/bin/gnome-terminal
