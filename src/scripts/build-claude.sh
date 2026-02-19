#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "Building claude projection..."

# Source all content files
for file in src/content/*.sh; do
    [ -f "$file" ] && source "$file"
done

for file in src/content/additional/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Clean and create output directories
rm -rf claude-plugins .claude-plugin
mkdir -p claude-plugins/amazon-location/.claude-plugin
mkdir -p claude-plugins/amazon-location/skills/amazon-location/references
mkdir -p .claude-plugin

# Generate marketplace.json at repo root
cp "src/templates/claude/marketplace.json" ".claude-plugin/marketplace.json"
echo "  Generated: .claude-plugin/marketplace.json"

# Generate plugin.json
cp "src/templates/claude/plugin.json" "claude-plugins/amazon-location/.claude-plugin/plugin.json"
echo "  Generated: claude-plugins/amazon-location/.claude-plugin/plugin.json"

# Generate .mcp.json for the plugin
cp "src/templates/claude/mcp.json" "claude-plugins/amazon-location/.mcp.json"
echo "  Generated: claude-plugins/amazon-location/.mcp.json"

# Generate reference files and build the references list
SKILL_REFERENCES_LIST=""
for entry_file in src/content/additional/*.sh; do
    [ -f "$entry_file" ] || continue
    entry_name=$(basename "$entry_file" .sh)
    entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')
    when_var="${entry_var}_HEADER_WHEN"
    name_var="${entry_var}_HEADER_NAME"
    content_var="${entry_var}_CONTENT"

    # Generate reference file
    output="claude-plugins/amazon-location/skills/amazon-location/references/$entry_name.md"

    # Check if there's a markdown file with the content (new approach)
    content_md_file="src/content/references/$entry_name.md"

    if [ -f "$content_md_file" ]; then
        # Use markdown file content (avoids bash heredoc parsing issues)
        {
            echo "# ${!name_var}"
            echo ""
            cat "$content_md_file"
        } > "$output"
    elif [ -n "${!content_var:-}" ]; then
        # Fallback to variable content (legacy approach)
        {
            echo "# ${!name_var}"
            echo ""
            echo "${!content_var}"
        } > "$output"
    else
        echo "  Warning: No content found for $entry_name"
        continue
    fi

    echo "  Generated: $output"

    # Add to references list
    [ -n "${!when_var:-}" ] && SKILL_REFERENCES_LIST+="- [${!name_var:-$entry_name}](./references/$entry_name.md) - ${!when_var}
"
done
export SKILL_REFERENCES_LIST

# Expand the amazon-location skill
template="src/templates/claude/skills/amazon-location/SKILL.md"
output="claude-plugins/amazon-location/skills/amazon-location/SKILL.md"
eval "cat <<TEMPLATE_EOF
$(cat "$template")
TEMPLATE_EOF
" > "$output"
echo "  Generated: $output"

echo "Claude projection complete!"
