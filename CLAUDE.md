# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

See [AGENTS.md](AGENTS.md) for full architecture, build system, and contribution details.

## Quick Reference

- All files in `context/`, `kiro-powers/`, `claude-plugins/`, `.claude-plugin/`, and `skills/` are **generated outputs** — never edit them directly. Source content lives in `src/`.
- Build all projections: `./src/scripts/build.sh`
- Verify build: `./src/scripts/verify-build.sh`
- No external dependencies — pure bash with variable expansion.

## Adding a New Feature Entry

1. Create `src/content/additional/<entry-name>.sh` with the 4 required `<ENTRY_NAME>_` variables
2. Create `src/content/references/<entry-name>.md` with implementation details
3. Run `./src/scripts/build.sh` — the build auto-discovers entries in `additional/` and generates all projection outputs
