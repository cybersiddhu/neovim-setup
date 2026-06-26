# mini.ai Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace nvim-treesitter-textobjects and nvim-treesitter-refactor with mini.ai to eliminate Neovim 0.12 crashes while preserving all select and move textobject keymaps.

**Architecture:** Remove the two crashing nvim-treesitter plugin dependencies from plugins.lua, strip their config from treesitter.lua, and introduce mini.ai in a new focused config file that provides treesitter-backed `af/if/ac/ic` textobjects and `]m/[m/]M/[M/]]/[[/][/[]` move motions via `MiniAi.move_cursor()`.

**Tech Stack:** Neovim 0.12, lazy.nvim, mini.ai (echasnovski/mini.ai), nvim-treesitter (highlight/indent only)

---

## File Map

| File | Action | Responsibility |
|------|--------|----------------|
| `lua/plugins.lua` | Modify | Remove textobjects + refactor deps; add mini.ai entry |
| `lua/config/treesitter.lua` | Modify | Strip all textobjects + refactor config; keep highlight/indent/pcall patch |
| `lua/config/mini-ai.lua` | Create | mini.ai setup with treesitter spec + move keymaps |

---

### Task 1: Remove broken deps and register mini.ai in plugins.lua

**Files:**
- Modify: `lua/plugins.lua` lines 8-10 (dependencies block of nvim-treesitter entry)

- [ ] **Step 1: Remove the two broken dependencies from the nvim-treesitter entry**

In `lua/plugins.lua`, replace the `dependencies` block of the nvim-treesitter entry from:

```lua
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
      { "nvim-treesitter/nvim-treesitter-refactor", branch = "master" },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
```

to:

```lua
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
```

- [ ] **Step 2: Add mini.ai plugin entry**

In `lua/plugins.lua`, add a new entry after the nvim-treesitter block (after the closing `},` of that entry, before `{ "HiPhish/rainbow-delimiters.nvim" ...`):

```lua
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    config = function()
      require("config.mini-ai")
    end,
  },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins.lua
git commit -m "feat(golang-nvim): swap nvim-treesitter-textobjects for mini.ai"
```

---

### Task 2: Strip textobjects and refactor config from treesitter.lua

**Files:**
- Modify: `lua/config/treesitter.lua`

- [ ] **Step 1: Replace the entire file content**

Rewrite `lua/config/treesitter.lua` to remove all textobjects/refactor/swap logic, keeping only the pcall workaround and the core treesitter setup:

```lua
-- Workaround: nvim 0.12 frees C nodes before injection directive handlers run;
-- the Lua object passes `if not node` but node:range() crashes on the dead pointer.
do
  local orig = vim.treesitter.get_node_text
  vim.treesitter.get_node_text = function(node, source, opts)
    local ok, result = pcall(orig, node, source, opts)
    return ok and result or ""
  end
end

local tree_config = require "nvim-treesitter.configs"
tree_config.setup {
  ensure_installed = {
    "go", "dockerfile", "gomod", "json", "markdown", "proto", "toml", "vim", "yaml", "graphql", "just",
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/config/treesitter.lua
git commit -m "feat(golang-nvim): strip textobjects+refactor from treesitter config"
```

---

### Task 3: Create mini-ai.lua config

**Files:**
- Create: `lua/config/mini-ai.lua`

- [ ] **Step 1: Create the config file**

Create `lua/config/mini-ai.lua` with the following content:

```lua
local ai = require("mini.ai")

ai.setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
  },
})

local function move(key, side, ai_type, id, method)
  vim.keymap.set("n", key, function()
    require("mini.ai").move_cursor(side, ai_type, id, { search_method = method })
  end)
end

-- function motions
move("]m", "left",  "a", "f", "next")
move("[m",  "left",  "a", "f", "prev")
move("]M", "right", "a", "f", "next")
move("[M",  "right", "a", "f", "prev")

-- class motions
move("]]", "left",  "a", "c", "next")
move("[[",  "left",  "a", "c", "prev")
move("][", "right", "a", "c", "next")
move("[]",  "right", "a", "c", "prev")
```

- [ ] **Step 2: Commit**

```bash
git add lua/config/mini-ai.lua
git commit -m "feat(golang-nvim): add mini.ai config with treesitter textobjects and move motions"
```

---

### Task 4: Verify in Neovim

There is no automated test suite for Neovim config. Verify manually:

- [ ] **Step 1: Launch Neovim and check lazy.nvim installs mini.ai**

```bash
nvim --headless "+Lazy sync" +qa
```

Expected: exits cleanly. If mini.ai was not previously installed, lazy.nvim fetches it.

- [ ] **Step 2: Open a Go file and verify textobject select**

Open any `.go` file. Position cursor inside a function body. Run:
- `vaf` → visual selection should expand to the full function including signature
- `vif` → visual selection should cover the function body only
- `vac` / `vic` → same for struct/type definitions

- [ ] **Step 3: Verify move motions**

In the same Go file with multiple functions:
- `]m` → cursor should jump to the start of the next function
- `[m` → cursor should jump back to start of current/previous function
- `]]` → cursor should jump to next type/struct definition
- `[[` → cursor should jump back

- [ ] **Step 4: Verify no decoration provider crash on markdown**

Open any `.md` file with a fenced code block (` ```go ... ``` `). Scroll around. The `conceal_line` decoration provider error from `query_predicates.lua` should not appear.

- [ ] **Step 5: Verify previously crashing textobject motion no longer crashes**

In a `.go` file, press `]m` several times to jump through functions. The `tsrange.lua:27` crash should no longer occur.
