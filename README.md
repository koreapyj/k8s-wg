# k8s-wg

WireGuard control container for a gateway pod running with `hostNetwork`.

- WireGuard runs in the node kernel; the image only carries `wg`, `wg-quick`,
  `ip` and `iptables` (nf_tables backend).
- The pod needs `NET_ADMIN` and `NET_RAW`.
- `wg-gw run` brings up every `wgt_*.conf` in `$CONF_DIR` (default
  `/etc/wg-gw`), adds `FORWARD` accept and TCP MSS clamp rules for `wgt+`,
  and removes them again on SIGTERM.
- Optional SNAT: with `SNAT_TO=<address>` and `SNAT_SOURCES=<cidr>[,<cidr>...]`,
  traffic from those sources leaving through `wgt+` is SNATed to `SNAT_TO`
  (inserted ahead of other POSTROUTING rules; `169.254.0.0/16` destinations
  are excluded).
- Optional egress pinning: with `EGRESS_ALLOW=<cidr>[,<cidr>...]` (IPv4 and/or
  IPv6), UDP sent from the tunnels' listen ports to any other destination is
  dropped. Use it when the tunnels sit behind a UDP proxy, so a peer never
  receives (and roams to) packets from another source address.

Images: `ghcr.io/koreapyj/k8s-wg:<version>` (from `v*` tags) and `:sha-<short>`.
