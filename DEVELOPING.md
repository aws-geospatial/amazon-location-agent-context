# Development Guide

This document covers the build system, content structure, and how to contribute new context entries.

## Directory Structure

```
/
├── kiro/                        # Kiro Power (generated output)
│   ├── POWER.md
│   ├── mcp.json
│   └── steering/
│       ├── address-input.md
│       ├── address-verification.md
│       └── ...
│
├── context/                     # Direct context (generated output)
│   ├── amazon-location.md
│   └── additional/
│       ├── address-input/
│       │   ├── BRIEF.md
│       │   └── AGENTS.md
│       └── ...
│
├── src/
│   ├── content/                 # Source content (shell variables)
│   │   ├── amazon-location.sh   # Core service documentation
│   │   └── additional/          # Additional context entries
│   │       ├── web-javascript.sh
│   │       ├── address-input.sh
│   │       └── ...
│   │
│   ├── templates/               # Projection templates
│   │   ├── base/                # Base context templates
│   │   │   ├── amazon-location.md
│   │   │   └── additional/
│   │   │       └── template/
│   │   │           ├── BRIEF.md
│   │   │           └── AGENTS.md
│   │   │
│   │   └── kiro/                # Kiro Power templates
│   │       ├── POWER.md
│   │       ├── mcp.json
│   │       └── steering/
│   │           └── template.md
│   │
│   └── scripts/                 # Build scripts
│       ├── build.sh             # Main build orchestrator
│       ├── build-base.sh        # Build context projection
│       ├── build-kiro.sh        # Build Kiro projection
│       └── evaluate-context-size.sh
│
├── README.md
├── DEVELOPING.md
└── ...
```

## Build System

The build system uses shell variable expansion to generate projections from source content files.

### Building Projections

```bash
# Build all projections
./src/scripts/build.sh

# Build specific projection
./src/scripts/build-base.sh    # Generates context/
./src/scripts/build-kiro.sh    # Generates kiro/
```

### Build Process

1. Clean output directories
2. Source all `src/content/*.sh` and `src/content/additional/*.sh` files
3. For core templates: Direct variable expansion
4. For additional entries: Iterate and generate one output per entry
5. Copy static files (e.g., mcp.json)

Output:

- `context/` - Base context projection
- `kiro/` - Kiro Power projection

Files in output directories should never be edited manually—they are overwritten on each build.

## Variable Naming Convention

Variables follow a structured naming pattern:

### Core Service Variables

```bash
AMAZON_LOCATION_API_OVERVIEW
AMAZON_LOCATION_MCP_SERVERS
```

### Additional Entry Variables

Each additional entry defines these variables:

```bash
<ENTRY_NAME>_HEADER_NAME       # Display name
<ENTRY_NAME>_HEADER_KEYWORDS   # Tags for discovery
<ENTRY_NAME>_HEADER_WHEN       # When to load this content
<ENTRY_NAME>_CONTENT           # Main content body
```

Example:

```bash
ADDRESS_INPUT_HEADER_NAME="Address Input"
ADDRESS_INPUT_HEADER_KEYWORDS="address form, autocomplete, validation"
ADDRESS_INPUT_HEADER_WHEN="Load when user asks about address forms"
ADDRESS_INPUT_CONTENT="# Address Input\n\n..."
```

## Adding New Content

### Add Core Content

1. Create/edit `src/content/<name>.sh`
2. Define variables with clear names
3. Reference in appropriate templates
4. Run build script

### Add Additional Entry

1. Create `src/content/additional/<entry-name>.sh`
2. Define 4 required variables with `<ENTRY_NAME>_` prefix
3. Run build script (automatically generates outputs)

Example:

```bash
# src/content/additional/my-feature.sh

MY_FEATURE_HEADER_NAME="My Feature"
MY_FEATURE_HEADER_KEYWORDS="keyword1, keyword2"
MY_FEATURE_HEADER_WHEN="Load when user asks about my feature"

read -r -d '' MY_FEATURE_CONTENT << 'EOF'
# My Feature

Content goes here...
EOF
```

The build automatically generates:

- `context/additional/my-feature/BRIEF.md`
- `context/additional/my-feature/AGENTS.md`
- `kiro/steering/my-feature.md`

### Add New Projection Type

1. Create `src/templates/<projection-name>/` directory
2. Add templates with variable placeholders
3. Create `src/scripts/build-<projection-name>.sh`
4. Update `src/scripts/build.sh` to call new build script

## Context Size Evaluation

After building, the script reports context sizes:

```bash
./src/scripts/evaluate-context-size.sh
```

This helps ensure context stays minimal and effective.
