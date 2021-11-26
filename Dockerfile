#
# Builder Stage
#
FROM golang:1.17-bullseye as builder

# Build tooling
WORKDIR /build

# IPMI Exporter
RUN set -ex \
    && git clone https://github.com/prometheus-community/ipmi_exporter.git \
    && cd ipmi_exporter/ \
    && make

#
# Final Stage
#
FROM debian:bullseye-slim

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        freeipmi

COPY --from=builder /build/ipmi_exporter/ipmi_exporter /usr/local/bin/ipmi_exporter

EXPOSE      9290
USER        nobody
ENTRYPOINT  [ "/usr/local/bin/ipmi_exporter" ]