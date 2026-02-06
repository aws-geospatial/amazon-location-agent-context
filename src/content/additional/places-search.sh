#!/bin/bash
# Address input form guidance

PLACES_SEARCH_HEADER_NAME="Places Search"

PLACES_SEARCH_HEADER_KEYWORDS="place serch, poi, places, point of interest"

PLACES_SEARCH_HEADER_WHEN=$(cat <<'EOF'
Search for places or points of interest
EOF
)

PLACES_SEARCH_CONTENT=$(cat <<'EOF'
# Places Search

Searching for places can help users identify points of interest, addresses or places. Searching for places can be based on text, location, categories or even different business chains.

## APIs Used

### SearchText
- Text-based search with query string
- Filter by categories, chains
- Specify result limits

### SearchNearby
- Location-based search with coordinates and radius
- Filter by categories, chains
- Distance-based results

### GetPlace
- Retrieve complete place details by PlaceId
- Contact information (if available)
- Business hours (if available)

## Best Practices

- Cache search results for better performance
- Implement pagination for large result sets
- Show distance/relevance indicators
- Handle no results gracefully
EOF
)
