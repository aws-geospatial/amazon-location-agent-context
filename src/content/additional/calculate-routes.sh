#!/bin/bash
# calculate routes guidance

CALCULATE_ROUTES_HEADER_NAME="Calculate Routes"

CALCULATE_ROUTES_HEADER_KEYWORDS="routing, routes, navigation, directions, calculate-routes, waypoints, turn-by-turn, route calculation"

CALCULATE_ROUTES_HEADER_WHEN="Calculate routes between locations with customizable travel options and display them on maps"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CALCULATE_ROUTES_CONTENT="$(cat "$SCRIPT_DIR/../references/calculate-routes.md")"
