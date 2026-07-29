#!/usr/bin/env bash
set -euo pipefail

SCOPE="${1:-global}"
AGENT_NAME="${2:-professor-api}"
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

# locate agent file
AGENT_FILE="$REPO_ROOT/.opencode/agents/$AGENT_NAME.md"
if [ ! -f "$AGENT_FILE" ]; then
    AGENT_FILE="$REPO_ROOT/agents/$AGENT_NAME.md"
fi

if [ ! -f "$AGENT_FILE" ]; then
    echo "[ERROR] Agent file not found: $AGENT_NAME.md" >&2
    exit 1
fi

if [ "$SCOPE" = "global" ]; then
    AGENT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/agents"
else
    AGENT_DIR="$(pwd)/.opencode/agents"
fi

mkdir -p "$AGENT_DIR"
cp "$AGENT_FILE" "$AGENT_DIR/$AGENT_NAME.md"

echo "[OK] Agent installed to: $AGENT_DIR"

# optionally set as default agent (global only)
if [ "${3:-}" = "--default" ] && [ "$SCOPE" = "global" ]; then
    CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/opencode.json"
    if [ -f "$CONFIG_FILE" ]; then
        # Use jq if available, else fallback to sed
        if command -v jq &>/dev/null; then
            jq --arg agent "$AGENT_NAME" '.default_agent = $agent' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
        else
            echo "[WARN] jq not found. Skipping config update."
        fi
        echo "[OK] Default agent set to '$AGENT_NAME'"
    else
        cat > "$CONFIG_FILE" <<-EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "default_agent": "$AGENT_NAME"
}
EOF
        echo "[OK] Global config created with default agent '$AGENT_NAME'"
    fi
fi

echo ""
echo "Installation complete. Restart opencode to use the agent."
echo "Usage: @${AGENT_NAME} Quero aprender a construir uma API"
