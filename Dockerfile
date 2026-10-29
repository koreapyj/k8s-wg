# WireGuard gateway control container.
# WireGuard itself is the node's kernel module; this image only carries the tools.
# Runs with hostNetwork and creates wgt_* interfaces in the node netns.
FROM docker.io/library/alpine:3.22.7

RUN apk add --no-cache \
      wireguard-tools-wg \
      wireguard-tools-wg-quick \
      iproute2 \
      iptables \
 && iptables -V | grep -q nf_tables

COPY --chmod=0755 wg-gw /usr/local/bin/wg-gw

ENTRYPOINT ["/usr/local/bin/wg-gw"]
