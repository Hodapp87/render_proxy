#!/bin/bash

# This worked with:
#    ssh -o ProxyCommand="nc -P user -X connect -x localhost:10000 %h %p" foo@bar
# ...and asks for the password interactively.
# ncat can do it non-interactively, I think.

# TODO: Check if PROXY_AUTH_PASSWORD is set, exit with error if unset or empty
# TODO: Generate tinyproxy_filter from environ somehow?

# TODO: Is port 10000 correct?
export PROXY_PORT="${PROXY_PORT:-10000}"
echo "Listening on port ${PROXY_PORT}"

cat <<EOF > tinyproxy.conf
Port ${PROXY_PORT}
Listen 0.0.0.0
Timeout 600
BasicAuth tinyproxy ${PROXY_AUTH_PASSWORD}
#Filter "tinyproxy_filter"
#FilterDefaultDeny yes
EOF

# TODO: 
#   dropbear -p 2222 -E -R -s
#   (Test with -F)
#   Get -D & authorized_keys in somehow (secret file?)

tinyproxy -d -c tinyproxy.conf
