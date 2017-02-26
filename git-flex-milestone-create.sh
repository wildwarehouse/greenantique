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

if [ ${#} == 0 ]
then
    PREV_MAJOR=$(curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones | jq "map(select(.title|test(\"^m[0-9]+[.][0-9]+[.][0-9].*\$\"))) | map(.title | split(\".\") | .[0] | .[1:] | tonumber) | max") &&
	if [ ${PREV_MAJOR} == "null" ]
	then
	    (
		DUE_ON=$(date --date "next year" +%Y-%m-%dT%H:%M:%SZ) &&
		    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"m0.0.0\", \"due_on\": \"${DUE_ON}\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones &&
		    git checkout -b v0 &&
		    cp /opt/docker/COPYING . &&
		    head --lines 20 /opt/docker/README.md | sed -e "s#greenantique#${GITHUB_UPSTREAM_REPOSITORY}#g" -e "wREADME.md" &&
		    git add COPYING README.md &&
		    git commit --allow-empty --message "init 0" &&
		    git checkout -b v0.0 &&
		    git checkout -b v0.0.0 &&
		    git push upstream v0 v0.0 v0.0.0
	    ) ||
		    (
			echo There was a problem creating major milestone 0 &&
			    exit 67
		    )
	else
	    (
		MAJOR=$((${PREV_MAJOR}+1)) &&
		    DUE_ON=$(date --date \"next month\" +%Y-%m-%dT%H:%M:%SZ) &&
		    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"m${MAJOR}.0.0\", \"due_on\": \"${DUE_ON}\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones &&
		    git fetch upstream v${PREV_MAJOR} &&
		    git checkout upstream/v${PREV_MAJOR} &&
		    git checkout -b v${MAJOR} &&
		    cp /opt/docker/COPYING . &&
		    head --lines 20 /opt/docker/README.md | sed -e "s#greenantique#${GITHUB_UPSTREAM_REPOSITORY}#g" -e "wREADME.md" &&
		    git add COPYING README.md &&
		    git commit --allow-empty --message "init ${MAJOR}" &&
		    git checkout -b v${MAJOR}.0 &&
		    git checkout -b v${MAJOR}.0.0 &&
		    git push upstream v${MAJOR} v${MAJOR}.0 v${MAJOR}.0.0
	    ) ||
		(
		    echo There was a problem creating major milestone ${MAJOR} &&
			exit 68
		)
	fi
elif [ ${#} == 1 ]
then
    PREV_MINOR=$(curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones | jq "map(select(.title|test(\"^m${1}[.][0-9]+[.][0-9].*\$\"))) | map(.title | split(\".\") | .[1] | tonumber) | max") &&
	if [ ${PREV_MINOR} == "null" ]
	then
	    echo There is no existing milestone with MAJOR=${1} &&
		exit 65
	else
	    (
		MINOR=$((${PREV_MINOR}+1)) &&
		    DUE_ON=$(date --date "next week" +%Y-%m-%dT%H:%M:%SZ) &&
		    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"m${1}.${MINOR}.0\", \"due_on\": \"${DUE_ON}\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones &&
		    git fetch upstream v${1}.${PREV_MINOR} &&
		    git checkout upstream/v${1}.${PREV_MINOR} &&
		    git checkout -b v${1}.${MINOR} &&
		    git commit --allow-empty --message "init ${1}.${MINOR}" &&
		    git checkout -b v${1}.${MINOR}.0.0 &&
		    git push upstream v${1}.${MINOR} v${1}.${MINOR}.0
	    ) ||
		(
		    echo There was a problem creating minor milestone ${1}.${MINOR} &&
			exit 69
		)
	fi
elif [ ${#} == 2 ]
then
    PREV_PATCH=$(curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones | jq "map(select(.title|test(\"^m${1}[.]${2}[.][0-9].*\$\"))) | map(.title | split(\".\") | .[2] | tonumber) | max") &&
	if [ ${PREV_PATCH} == "null" ]
	then
	    echo There is no existing milestone with MAJOR=${1} and MINOR=${2} &&
		exit 66
	else
	    (
		PATCH=$((${PREV_PATCH}+1)) &&
		    DUE_ON=$(date --date "tomorrow" +%Y-%m-%dT%H:%M:%SZ) &&
		    curl --user "${GITHUB_USER_ID}:${GITHUB_TOKEN}" --data "{\"title\": \"m${1}.${2}.${PATCH}\", \"due_on\": \"${DUE_ON}\"}" https://api.github.com/repos/${GITHUB_USER_ID}/${GITHUB_UPSTREAM_ORGANIZATION}/${GITHUB_UPSTREAM_REPOSITORY}/milestones &&
		    git fetch upstream v${1}.${2}.${PREV_PATCH} &&
		    git checkout upstream/v${1}.${2}.${PREV_PATCH} &&
		    git checkout -b v${1}.${2}.${PATCH} &&
		    git commit --allow-empty --message "init ${1}.${2}.${MINOR}" &&
		    git push upstream v${1}.${2}.${PATCH}
	    ) ||
		(
		    echo There was a problem creating patch milestone ${1}.${2}.${PATCH} &&
			exit 70
		)
	fi
else
    echo Usage:  git milestone create [major] [minor] &&
	exit 64
fi





