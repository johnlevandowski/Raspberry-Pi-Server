ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION:-latest}

ARG UNBOUND_VERSION

RUN apk add --no-cache unbound=${UNBOUND_VERSION} openssl bind-tools micro && \
        rm -f /etc/unbound/unbound.conf

COPY --chmod=755 scripts /usr/local/bin

COPY --chmod=644 conf /etc/unbound

RUN chown -R unbound:unbound /etc/unbound

USER unbound

WORKDIR /etc/unbound

EXPOSE 5335/tcp
EXPOSE 5335/udp

ENTRYPOINT [ "entrypoint.sh" ]
