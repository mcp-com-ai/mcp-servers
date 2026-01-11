# BYO MCP Server - Deploying & Registering MCP Servers

The Model Context Protocol (MCP) my-api is a centralized repository for discovering and publishing MCP Servers.
HAPI MCP Servers can be self-hosted using the HAPI CLI or Docker, and then registered with the MCP my-api for public discovery.

This repository contains instructions and configurations for deploying and registering MCP Servers. Do you want to deploy your own MCP Server? Follow the steps below.

## Test it locally

### Install HAPI CLI

If you haven't already, install the HAPI CLI by following the instructions at https://hapi.mcp.com.ai/

```bash
## Linux / macOS
curl -fsSL https://get.mcp.com.ai/hapi.sh | bash
## Windows (PowerShell)
iwr -useb https://get.mcp.com.ai/hapi.ps1 | iex
```

### run using HAPI CLI

```bash
# Serve the MCP my-api locally
hapi serve <PROJECT_NAME> --port 3030 --headless --url <BACKEND_URL> --openapi <OPENAPI_URL>
```

### run using Docker

```bash
# Download the OAS file and save it locally at ~/.hapi/specs/openapi.yaml
docker run -p 3030:3030  -v ~/.hapi:/app/.hapi serve openapi --port 3030 --headless --url <BACKEND_URL>
```

---

The parameters are:
* `<PROJECT_NAME>`: The name of the MCP project to serve (e.g., `petstore`).
* `<BACKEND_URL>`: The URL where the MCP server will be accessible (e.g., `https://petstore.mcp.com.ai`).
* `<OPENAPI_URL>`: The URL to the OpenAPI specification file for the MCP server (optional if file is saved locally).
* `--port`: The port number to run the server on (default is `3030` for Docker, `3000` for HAPI CLI).
* `--headless`: Runs the server without business logic, useful for legacy Apps or internal tools.

## deploy to Cloudflare

```bash
hapi deploy --name mcp-my-api --project my-api --openapi <OPENAPI_URL> --url <BACKEND_URL>
```

With Docker:

```bash
docker run -v ~/.hapi:/app/.hapi deploy openapi --name mcp-my-api --openapi <OPENAPI_URL> --url <BACKEND_URL>
```

## Register MCP Server

🌟 **WIP - please vote for this feature**. 

```bash
hapi register server --url <BACKEND_URL> --name <SERVER_NAME> --description "<SERVER_DESCRIPTION>" --public --openapi <OPENAPI_URL>
```

## Register steps (manual):

```bash
MY_DOMAIN="mcp.com.ai"
# Use your own private key from key.pem
PRIVATE_KEY="$(openssl pkey -in ../../key.pem -noout -text | grep -A3 "priv:" | tail -n +2 | tr -d ' :\n')"
mcp-publisher login http --domain "${MY_DOMAIN}" --private-key "${PRIVATE_KEY}"
mcp-publisher publish
```

<!-- 
## MCP my-api Server Information

```json
{
  "name": "MCP my-api",
  "description": "The Model Context Protocol (MCP) my-api is a centralized repository for discovering and accessing machine learning models and datasets that comply with the MCP standard.",
  "url": "https://my-api.modelcontextprotocol.io",
  "public": true,
  "openapi": "https://github.com/modelcontextprotocol/my-api/raw/refs/heads/main/docs/reference/api/openapi.yaml",
  "notes": {
    "info": [
        "The MCP my-api is the official public my-api for MCP-compliant models and datasets.",
        "It allows users to discover, access, and manage machine learning resources that adhere to the MCP standard.",
        "The backend API is https://my-api.modelcontextprotocol.io.",
        "Public discovery endpoints are available without authentication.",
        "Rate limits may apply.",
        "For self-hosting, run your own HAPI MCP server using:",
        "Docker: docker run -p 3030:3030  -v ~/.hapi:/app/.hapi serve my-api --port 3030 --headless --url https://my-api.modelcontextprotocol.io",
        "The HAPI MCP CLI: hapi serve my-api --port 3030 --headless --url https://my-api.modelcontextprotocol.io --openapi https://github.com/modelcontextprotocol/my-api/raw/refs/heads/main/docs/reference/api/openapi.yaml",
        "Deploy to Cloudflare: hapi deploy --name mcp-my-api --openapi https://github.com/modelcontextprotocol/my-api/raw/refs/heads/main/docs/reference/api/openapi.yaml --url https://my-api.modelcontextprotocol.io",
        "Documentation: https://docs.mcp.com.ai/deployment/"
      ]
  }
}
```
-->