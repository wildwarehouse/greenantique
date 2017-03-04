#!/bin/sh

docker ps --quiet --all | while read ID
do
    docker rm --volumes ${ID}
done &&
    docker volume ls --quiet --filter "dangling=true" | while read ID
    do
	docker volume rm ${ID}
    done &&
    docker images --quiet | while read ID
    do
	
	docker rmi ${ID}
    done
