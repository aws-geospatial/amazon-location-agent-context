#!/bin/bash
# Real-time device location tracking

DEVICE_TRACKING_HEADER_NAME="Device Tracking"

DEVICE_TRACKING_HEADER_KEYWORDS="tracker, device position, location history, fleet dashboard, GPS, real-time tracking, position updates, MQTT, IoT"

DEVICE_TRACKING_HEADER_WHEN="Track device locations in real time and query position history"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVICE_TRACKING_CONTENT="$(cat "$SCRIPT_DIR/../references/device-tracking.md")"
