#!/bin/bash
# Places search guidance

PLACES_SEARCH_HEADER_NAME="Places Search"

PLACES_SEARCH_HEADER_KEYWORDS="place search, poi, places, point of interest"

PLACES_SEARCH_HEADER_WHEN="Search for places or points of interest"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLACES_SEARCH_CONTENT="$(cat "$SCRIPT_DIR/../references/places-search.md")"
