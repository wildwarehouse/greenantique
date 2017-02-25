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
    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"${MAJOR}:${MINOR}:${PATCH}\", \"due_on\": \"$(date +"%Y%m%dT%H%M%SZ" -d "next month")\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY} &&
    (
	minor() {
	    get fetch upstream v${MAJOR}.${MINOR} &&
		patch ||
		    (
			[ ${MINOR} == 0 ] &&
			    git checkout -b v${MAJOR}.0 &&
			    cp /opt/docker/COPYING . &&
			    git add COPYING &&
			    git commit --allow-empty --message "init" &&
			    git push upstream v${MAJOR}.0 &&
			    minor
		    ) ||
		    (
			git fetch upstream v${MAJOR}.$((${MINOR}-1)) &&
			    git checkout -b v${MAJOR}.${MINOR} &&
			    git commit --allow-empty --message "init" &&
			    git push upstream v${MAJOR}.${MINOR} &&
			    patch
		    )
	} &&
	    patch() {
		get fetch upstream v${MAJOR}.${MINOR}.${PATCH} &&
		    (
			echo MILESTONE ALREADY EXISTS &&
			    exit 64
		    ) ||
			(
			    [ ${PATCH} == 0 ] &&
				git checkout -b v${MAJOR}.${MINOR}.0 &&
				cp /opt/docker/COPYING . &&
				git add COPYING &&
				git commit --allow-empty --message "init" &&
				git push upstream v${MAJOR}.${MINOR}.0
			) ||
			(
			    git fetch upstream v${MAJOR}.${MINOR}.$((${PATCH}-1)) &&
				git checkout -b v${MAJOR}.${MINOR}.${PATCH} &&
				git commit --allow-empty --message "init" &&
				git push upstream v${MAJOR}.${MINOR}.${PATCH}
			)
	    } &&
	    (
		git fetch upstream v${MAJOR} &&
		    minor ||
			(
			    [ ${MAJOR} == 0 ] &&
				git checkout -b v0 &&
				cp /opt/docker/COPYING . &&
				head -n 19 /opt/docker/README.md | sed -e "s#greenantique#${GITHUB_UPSTREAM_REPOSITORY}#" -e "wREADME.md" &&
				git add COPYING README.md &&
				git commit --allow-empty --message "init" &&
				git push upstream v0 &&
				minor
			) ||
			(
			    git fetch upstream v$((${MAJOR}-1)) &&
				git checkout -b v${MAJOR} &&
				head -n 19 /opt/docker/README.md | sed -e "s#greenantique#${GITHUB_UPSTREAM_REPOSITORY}#" -e "wREADME.md" &&
				git commit --allow-empty --message "init" &&
				git push upstream v${MAJOR} &&
				minor
			)
	    )
    )
