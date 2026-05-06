set shell := ["zsh", "-cu"]

default:
    @just --list

# Show available recipes.
list:
    @just --list

# List installed project skills.
skills:
    @npx skills list

# Symlink skills into agent config directories. Usage: just install [codex|claude|all]
install target="all":
    @case "{{target}}" in \
        codex) agent_dirs=("$HOME/.codex") ;; \
        claude) agent_dirs=("$HOME/.claude") ;; \
        all) agent_dirs=("$HOME/.codex" "$HOME/.claude") ;; \
        *) echo "Usage: just install [codex|claude|all]"; exit 2 ;; \
    esac; \
    for agent_dir in "${agent_dirs[@]}"; do \
        skill_dir="$agent_dir/skills"; \
        mkdir -p "$skill_dir"; \
        echo "Linking skills into $skill_dir"; \
        for source in "$PWD"/skills/*; do \
            [ -d "$source" ] || continue; \
            name="$(basename "$source")"; \
            dest="$skill_dir/$name"; \
            if [ -e "$dest" ] || [ -L "$dest" ]; then \
                if [ -L "$dest" ] && [ "$(realpath "$dest")" = "$source" ]; then \
                    echo "  ok $name"; \
                else \
                    echo "  skip $name (already exists)"; \
                fi; \
            else \
                ln -s "$source" "$dest"; \
                echo "  linked $name"; \
            fi; \
        done; \
    done

# Remove symlinks created by install. Usage: just uninstall [codex|claude|all]
uninstall target="all":
    @case "{{target}}" in \
        codex) agent_dirs=("$HOME/.codex") ;; \
        claude) agent_dirs=("$HOME/.claude") ;; \
        all) agent_dirs=("$HOME/.codex" "$HOME/.claude") ;; \
        *) echo "Usage: just uninstall [codex|claude|all]"; exit 2 ;; \
    esac; \
    for agent_dir in "${agent_dirs[@]}"; do \
        skill_dir="$agent_dir/skills"; \
        echo "Removing skill links from $skill_dir"; \
        for source in "$PWD"/skills/*; do \
            [ -d "$source" ] || continue; \
            name="$(basename "$source")"; \
            dest="$skill_dir/$name"; \
            if [ -L "$dest" ] && [ "$(realpath "$dest")" = "$source" ]; then \
                rm "$dest"; \
                echo "  removed $name"; \
            elif [ -e "$dest" ] || [ -L "$dest" ]; then \
                echo "  skip $name (not managed symlink)"; \
            else \
                echo "  missing $name"; \
            fi; \
        done; \
    done

# Update installed project skills using the skills CLI.
update:
    @npx skills update -y

# Re-add each GitHub source recorded in .skill-lock.json.
refresh-sources:
    @node -e 'const fs=require("fs"); const lock=JSON.parse(fs.readFileSync(".skill-lock.json","utf8")); const sources=[...new Set(Object.values(lock.skills||{}).map(skill=>skill.source).filter(Boolean))]; for (const source of sources) console.log(source);' | while read source; do \
        echo "Refreshing $source"; \
        npx skills add "$source" -y; \
    done

# Refresh the common Vercel skill packages explicitly.
refresh-vercel:
    @npx skills add vercel-labs/agent-skills -y
    @npx skills add vercel-labs/agent-browser -y
