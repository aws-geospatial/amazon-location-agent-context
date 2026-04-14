#!/bin/bash
# Google Maps to Amazon Location migration guidance for Android/Kotlin

GOOGLE_MIGRATION_ANDROID_HEADER_NAME="Google Maps Migration (Android)"

GOOGLE_MIGRATION_ANDROID_HEADER_KEYWORDS="google maps, migration, migrate, android, kotlin, google maps sdk android, com.google.android.gms.maps, GoogleMap, PlacesClient, FusedLocationProviderClient, switch from google maps"

GOOGLE_MIGRATION_ANDROID_HEADER_WHEN="Migrate Android application from Google Maps SDK for Android to Amazon Location Service"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOOGLE_MIGRATION_ANDROID_CONTENT="$(cat "$SCRIPT_DIR/../references/google-migration-android.md")"
