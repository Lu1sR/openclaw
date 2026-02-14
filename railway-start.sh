#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-18789}"

export OPENCLAW_STATE_DIR="${OPENCLAW_STATE_DIR:-/data/.openclaw}"
export OPENCLAW_WORKSPACE_DIR="${OPENCLAW_WORKSPACE_DIR:-/data/workspace}"

: "${OPENCLAW_GATEWAY_TOKEN:?OPENCLAW_GATEWAY_TOKEN is required}"

# Ensure volume dirs exist and are writable by the non-root user
mkdir -p "$OPENCLAW_STATE_DIR" "$OPENCLAW_WORKSPACE_DIR"
chown -R node:node /data

# Drop privileges and run gateway as node
exec su -s /bin/bash node -c "node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --port ${PORT} \
  --verbose"

