FROM debian:12

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        libayatana-appindicator3-1 \
        libpcap0.8 \
        wget \
        ca-certificates \
    && wget -q https://github.com/getlantern/lantern-binaries/raw/main/lantern-installer-64-bit.deb \
        -O /tmp/lantern-installer-64-bit.deb \
    && dpkg -i /tmp/lantern-installer-64-bit.deb \
    && rm /tmp/lantern-installer-64-bit.deb \
    && apt-get remove -y wget \
    && apt-get autoremove -y

RUN groupadd -g 1000 lantern && \
    useradd -m -s /usr/sbin/nologin -u 1000 -g 1000 lantern

COPY --chown=lantern:lantern settings.yaml /home/lantern/.lantern/

USER lantern
CMD ["lantern", "-headless", "-no-ui-http-token", "-socksaddr", "0.0.0.0:1080"]
