ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION:-latest}

ARG UNBOUND_VERSION

RUN apk add --no-cache unbound=${UNBOUND_VERSION} openssl drill && \
        rm -f /etc/unbound/unbound.conf

COPY --chmod=755 scripts /usr/local/bin

WORKDIR /etc/unbound

EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 www.google.com || exit 1

ENTRYPOINT [ "entrypoint.sh" ]
