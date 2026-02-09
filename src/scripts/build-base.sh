#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "Building context projection..."

# Source all content files
for file in src/content/*.sh; do
    [ -f "$file" ] && source "$file"
done

for file in src/content/additional/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Clean and create output directories
rm -rf context
mkdir -p context/additional

# Expand core templates
for template in src/templates/base/*.md; do
    [ -f "$template" ] || continue
    output="context/$(basename "$template")"
    eval "cat <<TEMPLATE_EOF
$(cat "$template")
TEMPLATE_EOF
" > "$output"
    echo "  Generated: $output"
done

# Expand additional entry templates
for entry_file in src/content/additional/*.sh; do
    [ -f "$entry_file" ] || continue
    
    entry_name=$(basename "$entry_file" .sh)
    entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')
    
    mkdir -p "context/additional/$entry_name"
    
    for template in src/templates/base/additional/template/*; do
        [ -f "$template" ] || continue
        
        output_name=$(basename "$template")
        output="context/additional/$entry_name/$output_name"
        
        # Replace <entry> placeholder with actual variable prefix, then expand
        eval "cat <<TEMPLATE_EOF
$(sed "s/<entry>/$entry_var/g" "$template")
TEMPLATE_EOF
" > "$output"
        
        echo "  Generated: $output"
    done
done

echo "Context projection complete!"
