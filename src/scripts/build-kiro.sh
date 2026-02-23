#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "Building kiro projection..."

# Source all content files
for file in src/content/*.sh; do
    [ -f "$file" ] && source "$file"
done

for file in src/content/additional/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Clean and create output directories
rm -rf kiro-powers
mkdir -p kiro-powers/amazon-location-service/steering

# Generate steering file list
STEERING_FILES_LIST=""
for entry_file in src/content/additional/*.sh; do
    [ -f "$entry_file" ] || continue
    entry_name=$(basename "$entry_file" .sh)
    entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')
    when_var="${entry_var}_HEADER_WHEN"
    [ -n "${!when_var:-}" ] && STEERING_FILES_LIST+="- ${!when_var} → [steering/$entry_name.md](steering/$entry_name.md)
"
done
export STEERING_FILES_LIST

# Expand core templates
for template in src/templates/kiro/*.md; do
    [ -f "$template" ] || continue
    output="kiro-powers/amazon-location-service/$(basename "$template")"
    eval "cat <<TEMPLATE_EOF
$(cat "$template")
TEMPLATE_EOF
" > "$output"
    echo "  Generated: $output"
done

# Copy static files
if [ -f "src/templates/kiro/mcp.json" ]; then
    cp "src/templates/kiro/mcp.json" "kiro-powers/amazon-location-service/mcp.json"
    echo "  Copied: kiro-powers/amazon-location-service/mcp.json"
fi

# Expand additional entry templates (steering files)
template="src/templates/kiro/steering/template.md"
if [ -f "$template" ]; then
    for entry_file in src/content/additional/*.sh; do
        [ -f "$entry_file" ] || continue
        
        entry_name=$(basename "$entry_file" .sh)
        entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')
        
        output="kiro-powers/amazon-location-service/steering/$entry_name.md"
        
        # Replace <entry> placeholder with actual variable prefix, then expand
        eval "cat <<TEMPLATE_EOF
$(sed "s/<entry>/$entry_var/g" "$template")
TEMPLATE_EOF
" > "$output"
        
        echo "  Generated: $output"
    done
fi

echo "Kiro projection complete!"
