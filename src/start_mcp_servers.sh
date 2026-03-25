#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Load .env if it exists
if [ -f src/.env ]; then
    set -a
    source src/.env
    set +a
fi

export PYTHONPATH="$PWD/src"

TIMEOUT=30

wait_for_health() {
    local port=$1
    local name=$2
    local elapsed=0

    while [ $elapsed -lt $TIMEOUT ]; do
        if curl -sf "http://localhost:${port}/health" > /dev/null 2>&1; then
            echo "✅ ${name} is ready on port ${port}"
            return 0
        fi
        sleep 1
        elapsed=$((elapsed + 1))
    done

    echo "❌ ${name} failed to start within ${TIMEOUT}s"
    exit 1
}

cleanup() {
    echo ""
    echo "🛑 Shutting down MCP servers..."
    kill $SALES_PID $INVENTORY_PID 2>/dev/null
    wait $SALES_PID $INVENTORY_PID 2>/dev/null
    echo "Done."
}
trap cleanup EXIT INT TERM

# Start Sales Analysis first
echo "🚀 Starting Sales Analysis MCP Server (port 8004)..."
PORT=8004 python -m mcp_servers.sales_analysis &
SALES_PID=$!

wait_for_health 8004 "Sales Analysis"

# Start Inventory after Sales Analysis is healthy
echo "🚀 Starting Inventory MCP Server (port 8005)..."
PORT=8005 python -m mcp_servers.inventory_server &
INVENTORY_PID=$!

wait_for_health 8005 "Inventory"

echo ""
echo "✨ All MCP servers are running"
echo "   Sales Analysis: http://localhost:8004/mcp"
echo "   Inventory:      http://localhost:8005/mcp"
echo ""
echo "Press Ctrl+C to stop all servers."

wait
