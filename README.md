# Amazon Location Service Agent Context

Comprehensive context for LLMs to build location-aware applications with Amazon Location Service. Provides ready-to-use integrations for Kiro Powers, Claude Code Plugins, and direct context usage.

## Overview

This package helps AI coding assistants understand Amazon Location Service APIs, best practices, and common patterns. It follows progressive disclosure principles—loading minimal context by default and expanding based on your specific task.

## Usage

### For Kiro Users

Install as a Power:

1. Open Kiro IDE
2. Go to Powers panel → Add Custom Power → Import power from GitHub
3. Enter: `https://github.com/aws-geospatial/amazon-location-agent-context/tree/main/kiro-powers/amazon-location`

Activate by keywords: Mention "location", "maps", "geocoding", "routing", "places", "geofencing", or "tracking" in your prompts.

Progressive loading: Kiro automatically loads relevant steering files based on your task.

### For Claude Code Users

Install as a Plugin:

1. Open Claude Code
2. Add the marketplace: `/plugin marketplace add aws-geospatial/amazon-location-agent-context`
3. Install the plugin: `/plugin install amazon-location@amazon-location-plugins`

The plugin includes skills for the full Amazon Location Service overview plus individual skills for address input, address verification, dynamic maps, places search, and web JavaScript integration. MCP server configuration for AWS documentation and API access is included automatically.

### For Direct Context Usage

Load files from `context/` directly into your LLM:

1. Start with `context/amazon-location.md` for the service overview
2. Add specific files from `context/additional/` as needed for your task or can be read as needed by the LLM client

### MCP Servers

The following MCP servers are recommended for full functionality:

- **aws-api-mcp-server**: AWS API exploration and execution
- **aws-knowledge-mcp-server**: AWS documentation access

Kiro Powers include MCP configuration automatically. For other clients, configure these servers manually.

## Key Principles

- **Progressive Disclosure**: In order for these sources of context for LLMs to be generally effective, they must avoid providing context unrelated to the current session. Minimal additional context to guide LLMs through common hallucinations provide a much more usable set of context files.
- **Custom Client Integrations**: People use LLMs through clients, and those clients have preferred methods for loading context and tooling. We should support preferred client integration methods (Kiro Powers, Claude Skills, etc.). The core context files are provided for generality and are tuned in such a way to encourage progressive disclosure for any client, without relying on specific client features.
- **Minimal Context Performs Best**: LLMs are able to drive a lot of value themselves. In order to effectively leverage this value and avoid adding weight to undesirable results, these context files must address common hallucinations and knowledge gaps but avoid as little extra information as possible.
- **Mutating Actions Require Human Approval**: All tool configuration in this package will be setup to be as powerful as possible without granting access to mutating actions without additional configuration or manual approval.
- **Self-Contained Projections**: Each projection (Kiro, Claude, etc.) must be self-contained for distribution. Content from the `src/context/` directory is merged into projections during the build process, as clients only package the projection directory (not the source context files).

## Contributing

The maintainers have some LLM performance benchmarks which are run before publishing updates. We would like to externalize this process, but for now, in order to ensure that additions do not decrease performance on existing supported queries, there is no process for contributions.

All commits updating context information must address why the context is being added to the repo in their commit message. This should include a brief description of the situation that requires the additional steering information and may include why existing steering information in this repo and published documentation is insufficient.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
