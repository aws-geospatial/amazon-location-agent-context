#!/bin/bash
# Address verification tips

ADDRESS_VERIFICATION_HEADER_NAME="Address Verification"

ADDRESS_VERIFICATION_HEADER_KEYWORDS="address form, address input, address verification, address validation, geocoding"

ADDRESS_VERIFICATION_HEADER_WHEN="Validate addresses input from users before taking actions or persisting to databases"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADDRESS_VERIFICATION_CONTENT="$(cat "$SCRIPT_DIR/../references/address-verification.md")"
