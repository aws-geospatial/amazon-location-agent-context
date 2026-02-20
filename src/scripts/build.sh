#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "Building context projection..."
./src/scripts/build-base.sh

echo "Building kiro projection..."
./src/scripts/build-kiro.sh

echo "Building claude and skills projections..."
./src/scripts/build-claude.sh

echo "Build complete!"
echo ""

./src/scripts/evaluate-context-size.sh
