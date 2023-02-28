FROM docker.io/ubuntu:20.04

RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y \
        libappindicator3-1 \
        libpcap0.8

COPY binaries/lantern-installer-64-bit.deb /root
RUN dpkg -i /root/lantern-installer-64-bit.deb

RUN groupadd -g 1000 lantern && \
    useradd -m -s /usr/sbin/nologin -u 1000 -g 1000 lantern

COPY --chown=lantern:lantern settings.yaml /home/lantern/.lantern/

USER lantern
CMD ["lantern", "-headless", "-no-ui-http-token"]
