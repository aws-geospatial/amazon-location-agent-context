#!/bin/bash
# dynamic map rendering guidance

DYNAMIC_MAP_HEADER_NAME="Dynamic Map Rendering"

DYNAMIC_MAP_HEADER_KEYWORDS="maps, map, dynamic map, maplibre, mapping"

DYNAMIC_MAP_HEADER_WHEN="Render dynamic maps with MapLibre"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DYNAMIC_MAP_CONTENT="$(cat "$SCRIPT_DIR/../references/dynamic-map.md")"
