<!--
MCP.com.ai — Server Registry
Deploying & Registering MCP Servers
-->

<p align="center">
  <img src="https://img.shields.io/badge/MCP-Model%20Context%20Protocol-1193b0?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Server%20Registry-Deploy%20%26%20Discover-da7756?style=for-the-badge" />
</p>

<h1 align="center">MCP Server Registry Integration</h1>

<p align="center">
  <b>Build Once. Deploy Everywhere. Discover Globally.</b><br/>
  Self-host, deploy, and register MCP servers with confidence using HAPI CLI, Docker, or Cloudflare Workers.
</p>

<p align="center">
  <a href="https://mcp.com.ai"><b>Website</b></a>
  ·
  <a href="https://docs.mcp.com.ai"><b>Docs</b></a>
  ·
  <a href="https://registry.modelcontextprotocol.io/?q=ai.com.mcp"><b>MCP Registry</b></a>  
  ·
  <a href="https://run.mcp.com.ai"><b>Run MCP</b></a>
  ·
  <a href="https://hapi.mcp.com.ai"><b>HAPI CLI</b></a>
</p>

---

## 🪝 What is this repo?

This repository is home to a growing collection of **production-ready MCP servers** that can be:

- **Self-hosted** locally or on your infrastructure
- **Deployed to the cloud** (Cloudflare Workers, Fly.io, or your own)
- **Registered globally** in the official MCP registry for discovery
- **Freely accessed** by anyone building with MCP

Each server follows best practices for **security, scalability, and auditability**.

---

## ⚡ Quick Start

### Option A — Run locally with HAPI CLI

1. **Install HAPI**
   ```bash
   # Linux / macOS
   curl -fsSL https://get.mcp.com.ai/hapi.sh | bash
   
   # Windows (PowerShell)
   iwr -useb https://get.mcp.com.ai/hapi.ps1 | iex
   ```

2. **Serve your MCP**
   ```bash
   hapi serve <PROJECT_NAME> \
     --port 3030 \
     --headless \
     --url <BACKEND_URL> \
     --openapi <OPENAPI_URL>
   ```

3. **Verify it works**
   ```bash
   curl -s http://localhost:3030/health
   curl -s -X POST http://localhost:3030/mcp \
     -H "Content-Type: application/json" \
     -d '{"jsonrpc":"2.0","id":1,"method":"ping"}'
   ```

### Option B — Run with Docker

```bash
docker run -p 3030:3030 \
  -v ~/.hapi:/app/.hapi \
  hapimcp/hapi-cli:latest \
  serve <PROJECT_NAME> \
  --port 3030 \
  --headless \
  --url <BACKEND_URL>
```

### Option C — Deploy to Cloudflare Workers

```bash
hapi login
hapi deploy \
  --name mcp-<PROJECT_NAME> \
  --project <PROJECT_NAME> \
  --openapi <OPENAPI_URL> \
  --url <BACKEND_URL>
```

---

## 🔧 Parameter Reference

- **`<PROJECT_NAME>`**: Name of the MCP project to serve (e.g., `petstore`, `my-api`)
- **`<BACKEND_URL>`**: Base URL of the backend API (e.g., `https://api.example.com`)
- **`<OPENAPI_URL>`**: URL or path to your OpenAPI v3 spec (optional if saved locally in `~/.hapi/specs/`)
- **`--port`**: Port number (default: 3000 for CLI, 3030 for Docker)
- **`--headless`**: Run without UI—useful for production and legacy APIs

---

## 🌍 Register with MCP Registry

### Automated (Coming soon)

```bash
hapi register server \
  --url <BACKEND_URL> \
  --name <SERVER_NAME> \
  --description "<SERVER_DESCRIPTION>" \
  --public \
  --openapi <OPENAPI_URL>
```

### Manual registration

1. Prepare your server metadata (name, description, OpenAPI URL)
2. Follow the [official MCP registry documentation](https://github.com/modelcontextprotocol/registry/tree/main/docs)
3. Submit a PR to the registry with your server entry

---

## 📚 Resources

- [HAPI CLI Documentation](https://docs.mcp.com.ai/components/hapi-server/)
- [MCP Registry](https://registry.modelcontextprotocol.io/)
- [OpenAPI to MCP Guide](https://docs.mcp.com.ai/)
- [Deployment Best Practices](https://docs.mcp.com.ai/deployment/)

---

## 🔐 Security First

When deploying MCP servers:

- **Authenticate** all requests to your backend API
- **Limit exposure** of sensitive endpoints
- **Monitor & log** all tool invocations
- **Use HTTPS** in production
- **Isolate** secrets in environment variables or credential stores

---

## ❓ FAQ

### What's the difference between running locally and deploying to production?

**Local**: Great for development, testing, and integration. Runs on your machine or internal infrastructure. Still, _HAPI MCP Servers are remote-only (HTTP Streamable)_.

**Production**: Deployed to Cloudflare Workers, Fly.io, or your own cloud—available globally or to your team, with monitoring and security hardening.

### Can I deploy the same MCP server to multiple platforms?

Yes. The same OpenAPI spec and HAPI configuration work on HAPI CLI, Docker, and Cloudflare Workers. Just adjust deployment flags.

### Do I need authentication for self-hosted MCP servers?

Recommended, especially if exposed publicly. Use OAuth2, API keys, or mutual TLS. HAPI can supports auth directly from your OpenAPI spec. Dynamic Client Registration is also supported.

### How do I test an MCP server before registering it?

Use the [MCP Server Evaluations skill](https://skills.sh/mcp-com-ai/mcp-server-evaluations-skills/mcp-server-evaluations), or manually test with curl:
```bash
curl -X POST http://localhost:3030/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"tools/list","id":1}'
```

### What if my OpenAPI spec is in Swagger 2.0?

Convert it to OpenAPI v3.x first. Tools like [API Transformer](https://www.apitransformer.com/) can help.

### Can I update my MCP server without downtime?

Yes. Use rolling deployments (Cloudflare Workers, Fly.io) or update your Docker image and restart with orchestration tools.

### How do I make my MCP server discoverable?

Register it in the [official MCP registry](https://registry.modelcontextprotocol.io/). Include clear naming, descriptions, and use standard operation names from your OpenAPI spec.

### What's the cost to deploy an MCP server?

**HAPI MCP Servers** have a flexible pricing with a free tier to get started and pay-as-you-go for scale.

Cloud providers may have their own costs:
- **Cloudflare Workers**: Pay per request and bandwidth.
- **Fly.io**: Based on resource usage (CPU, memory, bandwidth).
- **Self-hosted**: Depends on your hosting choice (Docker on VPS, Kubernetes, etc.).

Any cloud provider fees are separate from HAPI MCP Server costs.

### Does HAPI support WebSockets or Server-Sent Events (SSE)?

Yes. HAPI's Streamable HTTP transport supports both for real-time communication.

### How do I monitor and log MCP server usage?

Use HAPI's built-in logging (stdout, files) and integrate with APM tools (Datadog, New Relic, etc.), OpenTelemetry. Log JSON-RPC calls for audit trails.

---

<p align="center">
  <img src="https://img.shields.io/badge/La%20Rebelion%20Labs-Building%20API--First%20for%20AI-0d1117?style=for-the-badge&labelColor=1193b0&color=da7756" />
</p>
