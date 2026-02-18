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
mkdir -p claude-plugins/amazon-location/skills/amazon-location
mkdir -p .claude-plugin

# Generate marketplace.json at repo root
cp "src/templates/claude/marketplace.json" ".claude-plugin/marketplace.json"
echo "  Generated: .claude-plugin/marketplace.json"

# Generate plugin.json
cp "src/templates/claude/plugin.json" "claude-plugins/amazon-location/.claude-plugin/plugin.json"
echo "  Generated: claude-plugins/amazon-location/.claude-plugin/plugin.json"

# Generate skill references list for the top-level amazon-location skill
SKILL_REFERENCES_LIST=""
for entry_file in src/content/additional/*.sh; do
    [ -f "$entry_file" ] || continue
    entry_name=$(basename "$entry_file" .sh)
    entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')
    when_var="${entry_var}_HEADER_WHEN"
    [ -n "${!when_var:-}" ] && SKILL_REFERENCES_LIST+="- ${!when_var} → [../$entry_name/SKILL.md](../$entry_name/SKILL.md)
"
done
export SKILL_REFERENCES_LIST

# Generate .mcp.json for the plugin
cp "src/templates/claude/mcp.json" "claude-plugins/amazon-location/.mcp.json"
echo "  Generated: claude-plugins/amazon-location/.mcp.json"

# Expand the top-level amazon-location skill
template="src/templates/claude/skills/amazon-location/SKILL.md"
output="claude-plugins/amazon-location/skills/amazon-location/SKILL.md"
eval "cat <<TEMPLATE_EOF
$(cat "$template")
TEMPLATE_EOF
" > "$output"
echo "  Generated: $output"

# Expand additional entry skill templates
template="src/templates/claude/skills/template/SKILL.md"
if [ -f "$template" ]; then
    for entry_file in src/content/additional/*.sh; do
        [ -f "$entry_file" ] || continue

        entry_name=$(basename "$entry_file" .sh)
        entry_var=$(echo "$entry_name" | tr '[:lower:]-' '[:upper:]_')

        mkdir -p "claude-plugins/amazon-location/skills/$entry_name"
        output="claude-plugins/amazon-location/skills/$entry_name/SKILL.md"

        # Replace <entry> placeholder with actual variable prefix, then expand
        eval "cat <<TEMPLATE_EOF
$(sed "s/<entry>/$entry_var/g" "$template")
TEMPLATE_EOF
" > "$output"

        echo "  Generated: $output"
    done
fi

echo "Claude projection complete!"
