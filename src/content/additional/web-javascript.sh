#!/bin/bash
# Web JavaScript platform guidance

WEB_JAVASCRIPT_HEADER_NAME="Web JavaScript"

WEB_JAVASCRIPT_HEADER_KEYWORDS="javascript, web, browser, client-side"

WEB_JAVASCRIPT_HEADER_WHEN="Integrate Amazon Location services into web browser applications"

# Read content from markdown file (avoids bash heredoc parsing issues)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_JAVASCRIPT_CONTENT="$(cat "$SCRIPT_DIR/../references/web-javascript.md")"
