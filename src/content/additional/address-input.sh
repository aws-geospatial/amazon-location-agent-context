#!/bin/bash
# Address input form guidance

ADDRESS_INPUT_HEADER_NAME="Address Input"

ADDRESS_INPUT_HEADER_KEYWORDS="address form, address input, autocomplete, address validation, geocoding, GetPlace, type-ahead"

ADDRESS_INPUT_HEADER_WHEN="Create effective address input forms for users with address type ahead completion improving input speed and accuracy"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADDRESS_INPUT_CONTENT="$(cat "$SCRIPT_DIR/../references/address-input.md")"
