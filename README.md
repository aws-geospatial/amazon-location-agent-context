# Amazon Location Service Agent Context

Comprehensive context for LLMs to build location-aware applications with Amazon Location Service. Provides ready-to-use integrations as a [Kiro power](https://kiro.dev/powers/), [Claude Code plugin](https://code.claude.com/docs/en/plugins), [Agent Skill](https://agentskills.io), and direct context files.

## Overview

This package guides AI coding assistants through adding maps, places search, geocoding, routing, and other geospatial features with Amazon Location Service, including authentication setup, SDK integration, and best practices. It follows progressive disclosure principles—loading minimal context by default and expanding based on your specific task.

## Installation

### For Kiro Users

**Kiro IDE** — Install as a Power:

[![Install in Kiro](https://img.shields.io/badge/Install_in_Kiro-232F3E?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDIwIDI0IiBmaWxsPSJub25lIj48cGF0aCBkPSJNMy44MDA4MSAxOC41NjYxQzEuMzIzMDYgMjQuMDU3MiA2LjU5OTA0IDI1LjQzNCAxMC40OTA0IDIyLjIyMDVDMTEuNjMzOSAyNS44MjQyIDE1LjkyNiAyMy4xMzYxIDE3LjQ2NTIgMjAuMzQ0NUMyMC44NTc4IDE0LjE5MTUgMTkuNDg3NyA3LjkxNDU5IDE5LjEzNjEgNi42MTk4OEMxNi43MjQ0IC0yLjIwOTcyIDQuNjcwNTUgLTIuMjE4NTIgMi41OTU4MSA2LjY2NDlDMi4xMTEzNiA4LjIxOTQ2IDIuMTAyODQgOS45ODc1MiAxLjgyODQ2IDExLjgyMzNDMS42OTAxMSAxMi43NDkgMS41OTI1OCAxMy4zMzk4IDEuMjM0MzYgMTQuMzEzNUMxLjAyODQxIDE0Ljg3MzMgMC43NDUwNDMgMTUuMzcwNCAwLjI5OTgzMyAxNi4yMDgyQy0wLjM5MTU5NCAxNy41MDk1IC0wLjA5OTg4MDIgMjAuMDIxIDMuNDYzOTcgMTguNzE4NlYxOC43MTk1TDMuODAwODEgMTguNTY2MVoiIGZpbGw9IndoaXRlIj48L3BhdGg+PHBhdGggZD0iTTEwLjk2MTQgMTAuNDQxM0M5Ljk3MjAyIDEwLjQ0MTMgOS44MjQyMiA5LjI1ODkzIDkuODI0MjIgOC41NTQwN0M5LjgyNDIyIDcuOTE3OTEgOS45MzgyNCA3LjQxMjQgMTAuMTU0MiA3LjA5MTk3QzEwLjM0NDEgNi44MTAwMyAxMC42MTU4IDYuNjY2OTkgMTAuOTYxNCA2LjY2Njk5QzExLjMwNzEgNi42NjY5OSAxMS42MDM2IDYuODEyMjggMTEuODEyOCA3LjA5ODkyQzEyLjA1MTEgNy40MjU1NCAxMi4xNzcgNy45Mjg2MSAxMi4xNzcgOC41NTQwN0MxMi4xNzcgOS43MzU5MSAxMS43MjI2IDEwLjQ0MTMgMTAuOTYxNiAxMC40NDEzSDEwLjk2MTRaIiBmaWxsPSJibGFjayI+PC9wYXRoPjxwYXRoIGQ9Ik0xNS4wMzE4IDEwLjQ0MTNDMTQuMDQyMyAxMC40NDEzIDEzLjg5NDUgOS4yNTg5MyAxMy44OTQ1IDguNTU0MDdDMTMuODk0NSA3LjkxNzkxIDE0LjAwODYgNy40MTI0IDE0LjIyNDUgNy4wOTE5N0MxNC40MTQ0IDYuODEwMDMgMTQuNjg2MSA2LjY2Njk5IDE1LjAzMTggNi42NjY5OUMxNS4zNzc0IDYuNjY2OTkgMTUuNjczOSA2LjgxMjI4IDE1Ljg4MzEgNy4wOTg5MkMxNi4xMjE0IDcuNDI1NTQgMTYuMjQ3NCA3LjkyODYxIDE2LjI0NzQgOC41NTQwN0MxNi4yNDc0IDkuNzM1OTEgMTUuNzkzIDEwLjQ0MTMgMTUuMDMxOSAxMC40NDEzSDE1LjAzMThaIiBmaWxsPSJibGFjayI+PC9wYXRoPjwvc3ZnPg==)](https://kiro.dev/launch/powers/amazon-location-service)

> **Alternatively**, open Kiro IDE → `Powers` panel → `Available` tab → search for "Build geospatial applications with Amazon Location Service"

> **Note:** When using [Spec](https://kiro.dev/docs/specs/) mode, include "use the Amazon Location Service power" in your spec prompt for Kiro to activate it.

**Kiro CLI** — Install as an [Agent Skill](https://agentskills.io):

```bash
npx skills add aws-geospatial/amazon-location-agent-context -a kiro-cli
```

After installing, add the skill to your custom agent's resources in `.kiro/agents/<agent>.json`:

```json
{
  "resources": ["skill://.kiro/skills/**/SKILL.md"]
}
```

> **Note:** Kiro CLI skill installations don't include MCP configuration automatically. See [MCP Servers](#mcp-servers) below for manual setup.

Activate by keywords: Mention "location", "maps", "geocoding", "routing", "places", "geofencing", or "tracking" in your prompts.

### For Claude Code and Cursor Users

Install as a Plugin from the [Agent Plugins for AWS](https://github.com/awslabs/agent-plugins) marketplace:

**Claude Code:**

#### Add the marketplace

```bash
/plugin marketplace add awslabs/agent-plugins
```

#### Install the plugin

```bash
/plugin install amazon-location-service@agent-plugins-for-aws
```

**Cursor:**

You can install the **amazon-location-service** plugin from the [Cursor Marketplace](https://cursor.com/marketplace/aws). For additional information, please refer to the [Cursor plugin documentation](https://docs.cursor.com/plugins). You can also install within the Cursor application:

1. Open Cursor Settings
1. Navigate to `Plugins`
1. Search for `AWS`
1. Select the **amazon-location-service** plugin and click `Add to Cursor`
1. Select the scope for the installed plugin
1. The plugin should appear under Plugins → Installed

### For Other AI Coding Agents

For Claude Code and Cursor users, we recommend the [plugin above](#for-claude-code-and-cursor-users) for the best experience (includes MCP configuration). For all other agents that support the [Agent Skills](https://agentskills.io) standard:

The `skills/amazon-location-service/` directory is an [Agent Skills](https://agentskills.io) package — an open standard for giving agents new capabilities. Agent Skills are supported by VS Code (GitHub Copilot), OpenCode, Codex, Antigravity, and [more](https://github.com/vercel-labs/skills?tab=readme-ov-file#supported-agents).

**Install with the skills CLI:**

```bash
npx skills add aws-geospatial/amazon-location-agent-context
```

The CLI will guide you through selecting which agent(s) to install the skill for and at what scope (project or user level). For example:

```
$ npx skills add aws-geospatial/amazon-location-agent-context

? Select an agent: (Use arrow keys)
❯ Claude Code
  Cursor
  VS Code (GitHub Copilot)
  OpenCode
  Codex
  Antigravity

? Select a scope: (Use arrow keys)
❯ Project — install in current directory (committed with your project)
  Global — install globally for all projects
```

**Install for a specific agent:**

#### VS Code (GitHub Copilot)

```bash
npx skills add aws-geospatial/amazon-location-agent-context -a vscode
```

#### OpenCode

```bash
npx skills add aws-geospatial/amazon-location-agent-context -a opencode
```

#### Codex

```bash
npx skills add aws-geospatial/amazon-location-agent-context -a codex
```

Once installed, the skill activates automatically when your task involves location, maps, geocoding, routing, or other Amazon Location Service topics. The `SKILL.md` file includes the required frontmatter (`name`, `description`) per the Agent Skills spec, and reference files in `references/` are loaded on demand for progressive disclosure.

See [agentskills.io](https://agentskills.io) for the full list of compatible tools.

### For Direct Context Usage

If you're not using Kiro, Claude Code/Cursor plugins, or one of the [agents](https://github.com/vercel-labs/skills?tab=readme-ov-file#supported-agents) supported by Agent Skills, you can load the context files directly into your LLM:

1. Start with `context/amazon-location.md` for the service overview
2. Add specific files from `context/additional/` as needed for your task or can be read as needed by the LLM client

### MCP Servers

[Kiro power](#for-kiro-users) and [Claude Code/Cursor plugin](#for-claude-code-and-cursor-users) installations include MCP configuration automatically. If you're using [Agent Skills](#for-other-ai-coding-agents) or [direct context](#for-direct-context-usage), configure this server manually for full functionality:

- [AWS MCP Server](https://docs.aws.amazon.com/aws-mcp/latest/userguide/what-is-aws-mcp-server.html): AWS API exploration, execution, and documentation access
  - [Setup instructions](https://docs.aws.amazon.com/aws-mcp/latest/userguide/getting-started-aws-mcp-server.html)

## Key Principles

- **Progressive Disclosure**: In order for these sources of context for LLMs to be generally effective, they must avoid providing context unrelated to the current session. Minimal additional context to guide LLMs through common hallucinations provide a much more usable set of context files.
- **Custom Client Integrations**: People use LLMs through clients, and those clients have preferred methods for loading context and tooling. We should support preferred client integration methods (Kiro powers, Claude Code plugins, Agent Skills, etc.). The core context files are provided for generality and are tuned in such a way to encourage progressive disclosure for any client, without relying on specific client features.
- **Minimal Context Performs Best**: LLMs are able to drive a lot of value themselves. In order to effectively leverage this value and avoid adding weight to undesirable results, these context files must address common hallucinations and knowledge gaps but avoid as little extra information as possible.
- **Mutating Actions Require Human Approval**: All tool configuration in this package will be setup to be as powerful as possible without granting access to mutating actions without additional configuration or manual approval.
- **Self-Contained Projections**: Each projection (Kiro, Claude, Skills, etc.) must be self-contained for distribution. Content from the `src/context/` directory is merged into projections during the build process, as clients only package the projection directory (not the source context files).

## Contributing

The maintainers have some LLM performance benchmarks which are run before publishing updates. We would like to externalize this process, but for now, in order to ensure that additions do not decrease performance on existing supported queries, there is no process for contributions.

All commits updating context information must address why the context is being added to the repo in their commit message. This should include a brief description of the situation that requires the additional steering information and may include why existing steering information in this repo and published documentation is insufficient.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
