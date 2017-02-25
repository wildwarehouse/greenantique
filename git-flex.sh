#!/bin/sh

CMD=${1} &&
    shift &&
    git-flex-${CMD} ${@}
