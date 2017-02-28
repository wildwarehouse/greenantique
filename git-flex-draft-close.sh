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

ISSUE=$(git rev-parse --abbrev-ref HEAD | sed -e "s#^issues/##" -e "s#/.*\$##") &&
    DRAFT=$(git rev-parse --abbrev-ref HEAD | sed -e "s#^issues/[0-9][0-9][0-9][0-9][0-9]/##") &&
    ID=$(uuidgen) &&
    git fetch upstream issues/${ISSUE} &&
    git checkout -b rebase/${ISSUE}/${DRAFT}/${ID} &&
    git rebase issues/${ISSUE} &&
    git checkout -b reset/${ISSUE}/${DRAFT}/${ID} &&
    git reset --soft issues/${ISSUE} &&
    git commit
