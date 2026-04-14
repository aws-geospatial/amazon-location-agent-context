#!/bin/bash
# Google Maps to Amazon Location migration guidance for JavaScript/Web

GOOGLE_MIGRATION_WEB_HEADER_NAME="Google Maps Migration (JavaScript)"

GOOGLE_MIGRATION_WEB_HEADER_KEYWORDS="google maps, migration, migrate, switch from google, google.maps, @googlemaps, googlemaps, gmaps, google maps api, google places, google directions, PlacesService, DirectionsService, Geocoder, importLibrary"

GOOGLE_MIGRATION_WEB_HEADER_WHEN="Migrate JavaScript web application from Google Maps API to Amazon Location Service"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOOGLE_MIGRATION_WEB_CONTENT="$(cat "$SCRIPT_DIR/../references/google-migration-web.md")"
