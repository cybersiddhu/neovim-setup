# mini.ai Migration Design

## Problem

nvim-treesitter is archived. Neovim 0.12 changed the query match API so `match[id]`
returns a list of nodes instead of a single TSNode. nvim-treesitter's textobjects and
refactor modules crash in multiple places (`tsrange.lua`, `query_predicates.lua`) because
they call node methods (`:start()`, `:range()`) directly on what is now a table.
No fix is coming from upstream.

## Goal

Replace `nvim-treesitter-textobjects` and `nvim-treesitter-refactor` with
`echasnovski/mini.ai`, eliminating all Neovim 0.12 crashes while keeping the same
textobject select and move keymaps.

## What Gets Added

### Plugin: `echasnovski/mini.ai`

Added to `plugins.lua` as a standalone entry (not a dependency of nvim-treesitter).
Configured via `lua/config/mini-ai.lua`.

### Config: `lua/config/mini-ai.lua`

Two responsibilities:

**1. Select textobjects** — via `mini.ai.gen_spec.treesitter()`:

| Key | Textobject |
|-----|-----------|
| `af` | `@function.outer` |
| `if` | `@function.inner` |
| `ac` | `@class.outer` |
| `ic` | `@class.inner` |

**2. Move motions** — via `MiniAi.move_cursor(side, ai_type, id, opts)`:

| Key | Behaviour |
|-----|-----------|
| `]m` | next function start |
| `[m` | prev function start |
| `]M` | next function end |
| `[M` | prev function end |
| `]]` | next class start |
| `[[` | prev class start |
| `][` | next class end |
| `[]`  | prev class end |

## What Gets Removed

### From `plugins.lua`

- `nvim-treesitter/nvim-treesitter-textobjects` dependency on the nvim-treesitter entry
- `nvim-treesitter/nvim-treesitter-refactor` dependency on the nvim-treesitter entry

### From `lua/config/treesitter.lua`

- `swap_next` / `swap_prev` tables and the closure that builds them
- `text_objects` local table
- `refactor` local table
- `textobjects` and `refactor` keys from `tree_config.setup{}`
- The `lsp_interop` block inside text_objects

Keep: `highlight`, `incremental_selection`, `indent`, `ensure_installed`, pcall workaround.

## What Gets Dropped (No Replacement)

| Keymap | Old feature | Reason |
|--------|-------------|--------|
| `<A-n/p><A-f/c/p>` | swap next/prev function/class/param | low-use, no clean equivalent in mini.ai |
| `<leader>df` / `<leader>dF` | lsp_interop peek definition | aerial.nvim already provides peek |
| `grr` | treesitter smart rename | `<Leader>pn` (LSP rename) is equivalent |
| `gnd` / `gnD` / `gO` | treesitter goto/list definitions | `pc` / `pr` (LSP) covers these |
| `<a-*>` / `<a-#>` | goto next/prev usage | LSP document highlight covers this |

## Files Changed

| File | Change |
|------|--------|
| `lua/plugins.lua` | remove textobjects + refactor deps; add mini.ai entry |
| `lua/config/treesitter.lua` | strip textobjects + refactor config blocks |
| `lua/config/mini-ai.lua` | new file: mini.ai setup + move keymaps |
