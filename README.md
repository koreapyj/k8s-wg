# k8s-wg

WireGuard control container for a gateway pod running with `hostNetwork`.

- WireGuard runs in the node kernel; the image only carries `wg`, `wg-quick`,
  `ip` and `iptables` (nf_tables backend).
- The pod needs `NET_ADMIN` and `NET_RAW`.
- `wg-gw run` brings up every `wgt_*.conf` in `$CONF_DIR` (default
  `/etc/wg-gw`), adds `FORWARD` accept and TCP MSS clamp rules for `wgt+`,
  and removes them again on SIGTERM.

Images: `ghcr.io/koreapyj/k8s-wg:<version>` (from `v*` tags) and `:sha-<short>`.
