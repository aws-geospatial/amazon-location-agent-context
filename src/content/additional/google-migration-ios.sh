#!/bin/bash
# Google Maps to Amazon Location migration guidance for iOS/Swift

GOOGLE_MIGRATION_IOS_HEADER_NAME="Google Maps Migration (iOS)"

GOOGLE_MIGRATION_IOS_HEADER_KEYWORDS="google maps, migration, migrate, ios, swift, google maps sdk ios, GMSMapView, GMSPlacesClient, GMSGeocoder, switch from google maps"

GOOGLE_MIGRATION_IOS_HEADER_WHEN="Migrate iOS application from Google Maps SDK for iOS to Amazon Location Service"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOOGLE_MIGRATION_IOS_CONTENT="$(cat "$SCRIPT_DIR/../references/google-migration-ios.md")"
