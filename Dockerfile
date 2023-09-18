FROM registry.access.redhat.com/ubi9/openjdk-17:latest
ARG VERSION="production"

USER 0
COPY besu/. /opt/besu/

RUN groupadd besu && useradd -g besu -m -b /opt/besu besu && \
    chown besu:besu /opt/besu -R && \
    chmod 0755 /opt/besu

EXPOSE 9545 8545 8546 8547 8550 8551 30303

ENV BESU_RPC_HTTP_HOST 0.0.0.0
ENV BESU_RPC_WS_HOST 0.0.0.0
ENV BESU_GRAPHQL_HTTP_HOST 0.0.0.0
ENV BESU_PID_PATH "/tmp/pid"
ENV OTEL_RESOURCE_ATTRIBUTES="service.name=besu,service.version=$VERSION"


ENV PATH="/opt/besu/bin:${PATH}"

USER besu
WORKDIR /opt/besu

CMD ["sh", "-c", "besu --config-file=/etc/besu/config.toml"]
HEALTHCHECK --start-period=5s --interval=5s --timeout=1s --retries=10 CMD bash -c "[ -f /tmp/pid ]"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Besu" \
      org.label-schema.description="Enterprise Ethereum client" \
      org.label-schema.url="https://besu.hyperledger.org/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hyperledger/besu.git" \
      org.label-schema.vendor="Hyperledger" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"