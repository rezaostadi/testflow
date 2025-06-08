#!/bin/bash
# Fetch project dependencies for offline usage
set -e

# Pre-fetch Rust dependencies
if [ -f backend/Cargo.toml ]; then
  echo "Fetching Rust crates..."
  cargo fetch --manifest-path backend/Cargo.toml
fi

# Pre-fetch Node dependencies
if [ -f frontend/package.json ]; then
  echo "Installing Node packages..."
  (cd frontend && npm ci --prefer-offline --no-audit --progress=false)
fi

# Pre-fetch TypeScript client packages if any
if [ -f typescript-client/package.json ]; then
  echo "Installing TypeScript client packages..."
  (cd typescript-client && npm ci --prefer-offline --no-audit --progress=false)
fi

echo "Dependencies cached for offline usage."
