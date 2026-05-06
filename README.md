# .agents

Personal AI agent configuration and skills. This directory keeps reusable agent procedures in versioned plain files. Skills follow the [agentskills.io](https://agentskills.io/specification) specification.

## Directory Structure

```text
.agents/
├── README.md              # repository overview and usage notes
├── Justfile               # maintenance commands
├── .skill-lock.json       # installed skills lockfile
└── skills/
    └── <skill-name>/
        ├── SKILL.md       # Required: metadata + instructions
        ├── scripts/       # Optional: executable code
        ├── references/    # Optional: documentation
        ├── assets/        # Optional: templates, resources
        └── ...            # Any additional files or directories
```

## Configuration Model

This repository is the user-level agent configuration at `~/.agents`. Skills under `skills/` are reusable instructions that agents can discover and apply when a task matches the skill description. The lockfile records installed skill sources.

## Maintenance

Common commands:

```sh
just list             # show available recipes
just skills           # list installed skills
just install          # symlink skills into ~/.codex and ~/.claude; supports: codex, claude
just uninstall        # remove managed symlinks from ~/.codex and ~/.claude; supports: codex, claude
just update           # update installed skills with the skills CLI
```

## Getting Started

**Clone the repository:**

```sh
git clone https://github.com/tonybase/dotagents.git ~/.agents
```

**Install or update skills through `npx`:**

```sh
npx skills add vercel-labs/agent-skills
npx skills add vercel-labs/agent-browser
just update
```

Keep `skills/` and `.skill-lock.json` committed together so the setup can be restored later.
