#!/bin/bash

# before, validate if there is a server.json file in the current directory
if [ ! -f server.json ]; then
  echo "Error: server.json file not found in the current directory."
  exit 1
fi
# Do we have the mcp-publisher CLI installed?
if ! command -v mcp-publisher &> /dev/null; then
  echo "mcp-publisher could not be found, please install it first."
  exit 1
fi
# And the key.pem file?
if [ ! -f ../../key.pem ]; then
  echo "Error: key.pem file not found in the parent directory."
  exit 1
fi

MY_DOMAIN="mcp.com.ai"
# Use your own private key from key.pem
PRIVATE_KEY="$(openssl pkey -in ../../key.pem -noout -text | grep -A3 "priv:" | tail -n +2 | tr -d ' :\n')"
mcp-publisher login http --domain "${MY_DOMAIN}" --private-key "${PRIVATE_KEY}"
mcp-publisher publish