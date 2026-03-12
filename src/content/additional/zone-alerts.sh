#!/bin/bash
# Zone-based event alerts with geofencing

ZONE_ALERTS_HEADER_NAME="Zone Alerts"

ZONE_ALERTS_HEADER_KEYWORDS="geofence, geofencing, zone alerts, enter exit events, tracker, EventBridge, boundary detection, device tracking"

ZONE_ALERTS_HEADER_WHEN="Monitor device positions against geographic boundaries and react to zone entry or exit"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZONE_ALERTS_CONTENT="$(cat "$SCRIPT_DIR/../references/zone-alerts.md")"
