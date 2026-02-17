#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

echo "=== Build Verification ==="
echo ""

errors=0

# Function to check directory exists and has files
check_directory() {
    local dir="$1"
    local min_files="$2"
    
    if [ ! -d "$dir" ]; then
        echo "❌ FAIL: Directory '$dir' does not exist"
        errors=$((errors + 1))
        return 1
    fi
    
    local file_count=$(find "$dir" -type f \( -name "*.md" -o -name "*.json" \) | wc -l | tr -d ' ')
    
    if [ "$file_count" -lt "$min_files" ]; then
        echo "❌ FAIL: Directory '$dir' has $file_count files, expected at least $min_files"
        errors=$((errors + 1))
        return 1
    fi
    
    echo "✓ PASS: Directory '$dir' exists with $file_count files"
    return 0
}

# Function to check required files exist
check_file() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        echo "❌ FAIL: Required file '$file' does not exist"
        errors=$((errors + 1))
        return 1
    fi
    
    local bytes=$(wc -c < "$file" | tr -d ' ')
    
    if [ "$bytes" -eq 0 ]; then
        echo "❌ FAIL: File '$file' is empty"
        errors=$((errors + 1))
        return 1
    fi
    
    echo "✓ PASS: File '$file' exists ($bytes bytes)"
    return 0
}

# Function to check file doesn't contain unexpanded template variables
check_no_template_vars() {
    local file="$1"
    
    # Check for <entry> placeholder which should always be replaced
    if grep -q '<entry>' "$file" 2>/dev/null; then
        echo "❌ FAIL: File '$file' contains unexpanded <entry> placeholder"
        errors=$((errors + 1))
        return 1
    fi
    
    return 0
}

echo "## Checking output directories..."
echo ""
check_directory "context" 1
check_directory "context/additional" 1
check_directory "kiro-powers/amazon-location" 1
check_directory "kiro-powers/amazon-location/steering" 1
echo ""

echo "## Checking required files..."
echo ""
check_file "context/amazon-location.md"
check_file "kiro-powers/amazon-location/POWER.md"
check_file "kiro-powers/amazon-location/mcp.json"
echo ""

echo "## Checking for unexpanded template variables..."
echo ""
template_errors=0
while IFS= read -r file; do
    if ! check_no_template_vars "$file"; then
        template_errors=$((template_errors + 1))
    fi
done < <(find context kiro-powers -type f \( -name "*.md" -o -name "*.json" \) 2>/dev/null)

if [ "$template_errors" -eq 0 ]; then
    echo "✓ PASS: No unexpanded template variables found"
fi
echo ""

echo "## Checking context sizes..."
echo ""

# Check each output directory individually (max 500KB each)
MAX_DIR_BYTES=512000

check_directory_size() {
    local dir="$1"
    
    if [ ! -d "$dir" ]; then
        return 0
    fi
    
    local dir_bytes=0
    while IFS= read -r file; do
        bytes=$(wc -c < "$file" | tr -d ' ')
        dir_bytes=$((dir_bytes + bytes))
    done < <(find "$dir" -type f \( -name "*.md" -o -name "*.json" \) 2>/dev/null)
    
    if [ "$dir_bytes" -gt "$MAX_DIR_BYTES" ]; then
        echo "❌ FAIL: Directory '$dir' size ($dir_bytes bytes) exceeds maximum ($MAX_DIR_BYTES bytes)"
        errors=$((errors + 1))
    else
        echo "✓ PASS: Directory '$dir' size ($dir_bytes bytes) is within limits"
    fi
}

check_directory_size "context"
check_directory_size "kiro-powers/amazon-location"
echo ""

echo "=== Verification Complete ==="
echo ""

if [ "$errors" -gt 0 ]; then
    echo "❌ FAILED: $errors error(s) found"
    exit 1
else
    echo "✓ All checks passed!"
    exit 0
fi
