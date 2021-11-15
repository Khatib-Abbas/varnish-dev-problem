vcl 4.0;

import std;

backend default {
  .host = "caddy";
  .port = "80";
  .max_connections        = 300;
  .first_byte_timeout     = 300s;   # How long to wait before we receive a first byte from our backend?
  .connect_timeout        = 5s;     # How long to wait for a backend connection?
  .between_bytes_timeout  = 2s;     # How long to wait between bytes received from our backend?

  # Health check
  .probe = {
    .request =
      "HEAD /health-check HTTP/1.1"
      "Host: caddy-probe.local"
      "Connection: close"
      "User-Agent: Varnish Health Probe";
    .timeout = 5s;
    .interval = 5s;
    .window = 4;
    .threshold = 2;
  }
}
