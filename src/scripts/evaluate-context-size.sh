#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "=== Context Size Evaluation ==="
echo ""

# Function to evaluate an output directory
evaluate_output() {
    local output_name="$1"
    local output_path="$2"
    
    if [ ! -d "$output_path" ]; then
        echo "Output '$output_name' not found at $output_path"
        return
    fi
    
    echo "## $output_name"
    echo ""
    
    local total_bytes=0
    local total_words=0
    local file_count=0
    
    # Find all files and evaluate
    while IFS= read -r file; do
        local bytes=$(wc -c < "$file" | tr -d ' ')
        local words=$(wc -w < "$file" | tr -d ' ')
        total_bytes=$((total_bytes + bytes))
        total_words=$((total_words + words))
        file_count=$((file_count + 1))
        
        local rel_path="${file#$output_path/}"
        printf "  %-50s %8d bytes  %6d words\n" "$rel_path" "$bytes" "$words"
    done < <(find "$output_path" -type f \( -name "*.md" -o -name "*.json" \) | sort)
    
    echo ""
    echo "### Summary"
    printf "  Total files: %d\n" "$file_count"
    printf "  Total bytes: %d\n" "$total_bytes"
    printf "  Total words: %d\n" "$total_words"
    echo ""
}

# Evaluate all outputs
evaluate_output "kiro" "kiro"
evaluate_output "context" "context"

echo "=== Evaluation Complete ==="
