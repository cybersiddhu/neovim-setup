# Sync the neovim language setups in this repo into their devenv folders.
#
# Each devenv folder's .envrc points XDG_CONFIG_HOME at the folder itself, so
# nvim reads its config from <folder>/nvim. Only init.lua and lua/ are
# replaced there; plugin data, shada, undo, swap, sessions and lazy-lock.json
# are left alone. The previous init.lua and lua/ are backed up first under
# <folder>/nvim/.dev-setup-backup/<timestamp>/.
#
# Setups synced: golang, typescript, latex, python, terraform
# (luadev is not synced; nix has no devenv folder)

devenv := justfile_directory() / ".." / ".."
setups := "golang typescript latex python terraform"

# list recipes
default:
    @just --list

# show what `just sync <setup>` would change
diff setup: (_run "diff" setup)

# replace <folder>/nvim/{init.lua,lua} with this repo's copy
sync setup: (_run "sync" setup)

# show pending changes for every setup
diff-all:
    @for s in {{ setups }}; do just diff "$s"; done

# sync every setup
sync-all:
    @for s in {{ setups }}; do just sync "$s"; done

[private]
_run action setup:
    #!/usr/bin/env bash
    set -euo pipefail
    # setup name in this repo -> devenv folder whose nvim/ it feeds
    case "{{ setup }}" in
      golang)     folder=golang ;;
      typescript) folder=browserjs ;;
      latex)      folder=latex ;;
      python)     folder=python ;;
      terraform)  folder=terraform ;;
      *) echo "unknown setup '{{ setup }}' (expected: {{ setups }})" >&2; exit 1 ;;
    esac
    src="{{ justfile_directory() }}/{{ setup }}"
    dst="$(cd "{{ devenv }}/$folder" && pwd)/nvim"
    [ -d "$dst" ] || { echo "missing target $dst" >&2; exit 1; }

    if [ "{{ action }}" = "diff" ]; then
      echo "== {{ setup }} -> $dst"
      changes=$( { diff -q "$src/init.lua" "$dst/init.lua" 2>&1; diff -rq "$src/lua" "$dst/lua" 2>&1; } \
        | sed -e "s|$src/||g" -e "s|$dst/|target/|g" || true)
      echo "${changes:-  in sync}"
      exit 0
    fi

    backup="$dst/.dev-setup-backup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup"
    [ -e "$dst/init.lua" ] && cp -p "$dst/init.lua" "$backup/"
    [ -d "$dst/lua" ] && cp -Rp "$dst/lua" "$backup/"
    rm -rf "$dst/lua"
    cp -Rp "$src/lua" "$dst/lua"
    cp -p "$src/init.lua" "$dst/init.lua"
    echo "synced {{ setup }} -> $dst (backup: ${backup#"$dst"/})"
