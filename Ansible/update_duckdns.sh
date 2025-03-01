#!/bin/bash

# DuckDNS token and domain
TOKEN="189e53cf-237e-498c-8f74-21049c289bd8"
DOMAIN="leemang.duckdns.org"
IP="$1"

# Update the DuckDNS domain with the droplet IP
curl "https://www.duckdns.org/update?domains=${DOMAIN}&token=${TOKEN}&ip=${IP}"
