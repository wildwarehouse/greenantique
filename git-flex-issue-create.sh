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

MAJOR=${1} &&
    MINOR=${2} &&
    PATCH=${3} &&
    shift &&
    shift &&
    shift &&
    git fetch upstream v${MAJOR}.${MINOR}.${PATCH} &&
    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"${@}\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/issues
    git checkout -b issues/$(printf %05d ) &&
    git push upstream issues/$(print %05d ) &&
