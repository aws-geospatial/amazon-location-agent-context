# Development Guide

This document covers the build system, content structure, and how to contribute new context entries.

## Directory Structure

```
/
├── kiro-powers/                 # Kiro Power (generated output)
│   └── amazon-location/
│       ├── POWER.md
│       ├── mcp.json
│       └── steering/
│           ├── address-input.md
│           ├── address-verification.md
│           └── ...
│
├── plugins/                     # Claude Code Plugin (generated output)
│   └── amazon-location/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── .mcp.json
│       └── skills/
│           └── amazon-location/
│               ├── SKILL.md
│               └── references/
│                   ├── address-input.md
│                   ├── address-verification.md
│                   └── ...     # Loaded on demand by Claude
│
├── skills/                      # Agent Skills (generated output)
│   └── amazon-location-service/
│       ├── SKILL.md
│       └── references/
│           ├── address-input.md
│           ├── address-verification.md
│           └── ...              # Loaded on demand by compatible tools
│
├── .claude-plugin/              # Claude Code Marketplace (generated output)
│   └── marketplace.json
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
│   │   ├── kiro/                # Kiro Power templates
│   │   │   ├── POWER.md
│   │   │   ├── mcp.json
│   │   │   └── steering/
│   │   │       └── template.md
│   │   │
│   │   └── claude/              # Claude Code Plugin templates
│   │       ├── plugin.json
│   │       ├── marketplace.json
│   │       ├── mcp.json
│   │       └── skills/
│   │           └── amazon-location/
│   │               ├── SKILL.md
│   │               └── references/
│   │                   └── template.md
│   │
│   └── scripts/                 # Build scripts
│       ├── build.sh             # Main build orchestrator
│       ├── build-base.sh        # Build context projection
│       ├── build-kiro.sh        # Build Kiro projection
│       ├── build-claude.sh      # Build Claude Code projection
│       └── evaluate-context-size.sh
│
├── README.md
├── AGENTS.md
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
./src/scripts/build-kiro.sh    # Generates kiro-powers/amazon-location/
./src/scripts/build-claude.sh  # Generates plugins/amazon-location/, .claude-plugin/, and skills/amazon-location-service/
```

### Build Process

1. Clean output directories
2. Source all `src/content/*.sh` and `src/content/additional/*.sh` files
3. For core templates: Direct variable expansion
4. For additional entries: Iterate and generate one output per entry
5. Copy static files (e.g., mcp.json)

Output:

- `context/` - Base context projection
- `kiro-powers/amazon-location/` - Kiro Power projection
- `plugins/amazon-location/` - Claude Code Plugin projection
- `skills/amazon-location-service/` - Agent Skills projection
- `.claude-plugin/` - Claude Code Marketplace manifest

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
- `kiro-powers/amazon-location/steering/my-feature.md`
- Content is added as a reference file in `plugins/amazon-location/skills/amazon-location-service/references/my-feature.md`

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

## Local Testing with Kiro

To test the power locally while developing:

1. Run the build: `./src/scripts/build.sh`
2. In Kiro IDE, go to Powers panel → Add Custom Power → Import power from a folder
3. Select the `kiro-powers/amazon-location/` directory from your local checkout

This lets you iterate on content changes and immediately test them in Kiro without publishing.

## Local Testing with Claude Code

To test the Claude Code plugin locally while developing:

1. Run the build: `./src/scripts/build.sh`
2. In Claude Code, add the local marketplace: `/plugin marketplace add ./`
3. Install the plugin: `/plugin install amazon-location@amazon-location-plugins`

Alternatively, you can test the plugin directly without the marketplace:

```bash
claude --plugin-dir ./plugins/amazon-location
```

After making changes, rebuild and restart Claude Code to pick up updates.

## Releasing

This project uses [Semantic Versioning](https://semver.org/) with GitHub tags and releases. The version in the template files (`plugin.json`, `marketplace.json`) is the source of truth.

### Release Process

1. Update `CHANGELOG.md` — move items from `[Unreleased]` to a new version heading
2. Update the version in these template files:
   - `src/templates/claude/plugin.json` (`version` field)
   - `src/templates/claude/marketplace.json` (both `metadata.version` and the plugin entry `version`)
   - `src/templates/claude/skills/amazon-location-service/SKILL.md` (`metadata.version` in frontmatter) — note: the Agent Skills spec uses `MAJOR.MINOR` format (e.g., `"1.0"`) rather than full semver, so only update the major and minor components here
3. Run the build: `./src/scripts/build.sh`
4. Run verification: `./src/scripts/verify-build.sh`
5. Commit everything (source changes, built output, changelog)
6. Create a Git tag: `git tag v<version>` (e.g., `git tag v1.1.0`)
7. Push with tags: `git push origin main --tags`
8. Create a GitHub Release from the tag, using the changelog entry as the release notes
9. Update the Claude Code plugin in the [agent-plugins](https://github.com/awslabs/agent-plugins) marketplace — the Kiro power and Agent Skills projection are published directly from this repo, but the Claude Code plugin is distributed through that separate marketplace repo. Copy the built `plugins/amazon-location-service/` output there and open a PR.

### Version Bumping Guide

- Patch (`1.0.x`): Typo fixes, minor wording improvements, no new content
- Minor (`1.x.0`): New additional entries, expanded guidance, new projection types
- Major (`x.0.0`): Breaking changes to context structure, removed content, renamed projections
