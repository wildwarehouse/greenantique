FROM fedora:25
COPY run.sh entrypoint.sh docker.repo config known_hosts post-commit.sh git-flex.sh git-flex-scratch.sh /opt/docker/
RUN ["/usr/bin/sh", "/opt/docker/run.sh"]
VOLUME /usr/local/src
WORKDIR /usr/local/src
ENTRYPOINT ["/usr/bin/sh", "/opt/docker/entrypoint.sh"]
CMD []