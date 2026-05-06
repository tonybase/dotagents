# .agents

Personal AI agent configuration and skills. This directory keeps reusable agent procedures in versioned plain files.

## Directory Structure

```text
.agents/
+-- README.md              # repository overview and usage notes
+-- Justfile               # maintenance commands
+-- .skill-lock.json       # installed skills lockfile
`-- skills/
    `-- <skill-name>/
        `-- SKILL.md       # skill instructions
```

## Configuration Model

This repository is the user-level agent configuration at `~/.agents`. Skills under `skills/` are reusable instructions that agents can discover and apply when a task matches the skill description. The lockfile records installed skill sources.

## Maintenance

Common commands:

```sh
just list             # show available recipes
just skills           # list installed skills
just install          # symlink skills into ~/.codex and ~/.claude
just install codex    # symlink skills into ~/.codex only
just install claude   # symlink skills into ~/.claude only
just uninstall        # remove managed symlinks from ~/.codex and ~/.claude
just uninstall codex  # remove managed symlinks from ~/.codex only
just uninstall claude # remove managed symlinks from ~/.claude only
just update           # update installed skills with the skills CLI
```

## Getting Started

Install or update skills through `npx`:

```sh
npx skills add vercel-labs/agent-skills
npx skills add vercel-labs/agent-browser
just update
```

Keep `skills/` and `.skill-lock.json` committed together so the setup can be restored later.
