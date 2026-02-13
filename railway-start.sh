#!/usr/bin/env bash
set -euo pipefail

# Railway injects PORT; default if missing (local runs)
PORT="${PORT:-18789}"

# Persist everything on the Railway volume
export OPENCLAW_STATE_DIR="${OPENCLAW_STATE_DIR:-/data/.openclaw}"
export OPENCLAW_WORKSPACE_DIR="${OPENCLAW_WORKSPACE_DIR:-/data/workspace}"

# Safety: fail early if token isn't set (prevents accidental unauthenticated exposure)
: "${OPENCLAW_GATEWAY_TOKEN:?OPENCLAW_GATEWAY_TOKEN is required}"

# Bind to LAN because Railway routes into the container.
# (If you can do a private ingress instead, see security notes below.)
exec node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --port "${PORT}" \
  --verbose
