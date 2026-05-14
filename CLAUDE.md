# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration based on NvChad v2.5. NvChad is used as a plugin (imported from NvChad/NvChad), with custom configurations extending its base functionality. The configuration follows NvChad's modular structure where you import base modules and override/extend them.

## Common Commands

This repo has no traditional build/test/lint pipeline — it is loaded by Neovim at startup. Use these in-editor commands to manage and verify the config:

- `:Lazy` - Open lazy.nvim UI (sync/update/install/clean plugins). `lazy-lock.json` pins plugin versions; commit it after intentional updates.
- `:Lazy sync` - Install missing plugins and update existing ones to match `lazy-lock.json` / specs.
- `:Lazy update` - Pull latest versions of plugins (then commit `lazy-lock.json`).
- `:Mason` - Open Mason UI to install/uninstall LSP servers, formatters, linters.
- `:MasonInstall <pkg>` - Install a Mason package (e.g. `:MasonInstall stylua`).
- `:TSUpdate` - Update Treesitter parsers (parsers listed in `lua/configs/treesitter.lua`).
- `:LspInfo` - Inspect attached LSP clients for the current buffer.
- `:ConformInfo` - Inspect conform.nvim formatter status.
- `:checkhealth` - Diagnose Neovim/plugin/runtime issues. Use `:checkhealth lazy`, `:checkhealth mason`, etc. to scope.
- `nvim --headless "+Lazy! sync" +qa` - Headless plugin sync (useful when verifying changes from the shell).

After editing any `lua/` file, reload by restarting Neovim — there is no hot-reload step.

## Architecture

### Configuration Loading Order

1. `init.lua` - Entry point that bootstraps lazy.nvim and loads plugins
2. `lua/configs/lazy.lua` - Lazy.nvim configuration
3. NvChad base plugins are imported via `import = "nvchad.plugins"`
4. Custom plugins are loaded from `lua/plugins/` directory
5. Theme files are loaded from base46 cache
6. `lua/options.lua` - Vim options (after loading NvChad defaults)
7. `lua/autocmds.lua` - Autocommands (after loading NvChad defaults)
8. `lua/mappings.lua` - Keymaps (loaded via vim.schedule)

### Directory Structure

- `lua/plugins/*.lua` - Plugin specifications (lazy.nvim format)
- `lua/configs/*.lua` - Plugin configuration modules
- `lua/chadrc.lua` - NvChad UI configuration (theme, overrides)
- `lua/options.lua` - Custom vim options
- `lua/mappings.lua` - Custom keymaps
- `lua/autocmds.lua` - Custom autocommands

### Plugin Configuration Pattern

Plugins follow this pattern:
1. Plugin spec in `lua/plugins/*.lua` defines the plugin and lazy-loading
2. Configuration code lives in `lua/configs/*.lua`
3. Plugin spec references config via `config = function() require "configs.configname" end` or `opts = require "configs.configname"`

## Key Customizations

### LSP Servers (lua/configs/lspconfig.lua)
Enabled LSP servers: html, cssls, ts_ls, eslint, clangd, gopls, rust_analyzer, jsonls, bashls, yamlls, marksman, lua_ls, terraformls, dockerls

### Formatters (lua/configs/conform.lua)
- Lua: stylua
- JS/TS: prettier
- JSON: prettier, jq
- YAML: prettier, yq
- Markdown: prettier, markdownlint
- Shell: shfmt

Format on save is disabled by default (commented out in conform.lua).

### Linters (lua/configs/lint.lua)
Additional code quality checks beyond LSP:
- Shell: shellcheck (best practices, common errors)
- YAML: yamllint (indentation, syntax, style)
- Markdown: markdownlint (style, links, structure)

Note: ESLint runs as LSP server, not as linter (no duplication).

### Treesitter Parsers (lua/configs/treesitter.lua)
Auto-installs parsers for: vim, lua, html, css, json, javascript, typescript, bash, markdown, yaml, dockerfile, toml, go, python, rust, c, cpp, sql, hcl, graphql, prisma

Modules enabled:
- `highlight`: Syntax highlighting
- `indent`: Smart indentation
- `fold`: Code folding support
- `incremental_selection`: Progressive selection expansion/reduction
- `textobjects`: Smart selection, navigation, and manipulation of code structures

**Incremental Selection** (expand/reduce selection progressively):
- `Ctrl+Space` - Initialize selection and expand (word → expression → function → class)
- `Ctrl+s` - Expand to outer scope
- `Backspace` - Reduce selection

**Textobjects - Select** (visual mode shortcuts):
- Functions: `vaf` (outer), `vif` (inner)
- Classes: `vac` (outer), `vic` (inner)
- Conditionals: `vai` (outer), `vii` (inner)
- Loops: `val` (outer), `vil` (inner)
- Parameters: `vaa` (with comma), `via` (value only)

**Textobjects - Move** (navigate between code structures):
- Functions: `]m` / `[m` (next/previous start), `]M` / `[M` (next/previous end)
- Classes: `]c` / `[c` (next/previous start), `]C` / `[C` (next/previous end)
- Parameters: `]a` / `[a` (next/previous)

**Textobjects - Swap** (exchange parameters):
- `<leader>a` - Swap current parameter with next
- `<leader>A` - Swap current parameter with previous

### Code Folding
- Uses Treesitter-based folding (foldmethod = expr, foldexpr = v:lua.vim.treesitter.foldexpr())
- Fold module enabled in treesitter config (lua/configs/treesitter.lua)
- Starts with all folds open (foldlevel = 99)
- Automatically folds functions, classes, blocks, and other language constructs
- Uses Vim default fold commands (no custom keymaps):
  - `za`: Toggle current fold
  - `zo`: Open current fold
  - `zc`: Close current fold
  - `zR`: Open all folds
  - `zM`: Close all folds
  - `zj`: Jump to next fold
  - `zk`: Jump to previous fold

### AI Integration Plugins

**Claude Code** (lua/plugins/claudecode.lua) - Currently enabled
- `<leader>ac` - Toggle Claude Code
- `<leader>af` - Focus Claude Code
- `<leader>ar` - Resume session
- `<leader>aC` - Continue session
- `<leader>am` - Select model
- `<leader>ab` - Add current buffer
- `<leader>as` - Send to Claude (visual mode)
- `<leader>aa` - Accept diff
- `<leader>ad` - Deny diff
- `<leader>av` - Send `/review` command with file:line info (normal: current line, visual: selection range)

**Copilot** (lua/plugins/copilot.lua) - Enabled
- Integrated with nvim-cmp for completions
- Suggestion and panel UI disabled in favor of cmp integration

### Terminal & Git Integration

**ToggleTerm** keymaps:
- `<leader>h` - Horizontal terminal
- `<leader>v` - Vertical terminal (width: 60)
- `<leader>o` - Float terminal (size: 80)

**Git Integration**:
- `<leader>gh` - Git file history (Diffview - opens in a new tab, read-only, safe)
- `<leader>gb` - Telescope picker of commits touching the current file (floating, no tab)
- `<leader>gn` - Neogit log scoped to the current file (current window, no tab)
- `<leader>gt` - Tig log for the current file (floating terminal)
- `<leader>gT` - Tig log for the whole repo (floating terminal, toggles)
- `<leader>gs` - Tig status, interactive staging/commit (floating terminal, toggles)

**Window Navigation**: `<C-h/j/k/l>` works in both normal and terminal mode for seamless window switching

### Custom Keymaps (lua/mappings.lua)

**LSP**:
- `<leader>ca` - Code action
- `<leader>cf` - Format

**JSON/XML/JWT Tools**:
- `<leader>jf` - Format JSON (jq)
- `<leader>jc` - Minify JSON (jq -c)
- `<leader>jd` - Decode JWT in new split window (jwt-cli)
  - Normal mode: Decode current line
  - Visual mode: Decode selected text
- `<leader>xf` - Format XML (xmllint)
- `<leader>xc` - Minify XML (xmllint)

**Diagnostics**:
- `<leader>l` - Toggle diagnostic display (errors only ↔ all levels)

**Utilities**:
- `<leader>me` - Toggle mouse mode (enabled/disabled)
- `<leader>mv` - Markdown preview (glow in vertical split)
- `<leader>fr` - Telescope resume
- `jk` - Exit insert mode

### Terminal Behavior

- Auto-enters insert mode when entering terminal buffers
- `<C-q>` in terminal closes the terminal (and tab if in dedicated tab)
- `<Esc>` works normally in terminal programs (vim, less, etc.)
- Mouse is disabled by default (`vim.opt.mouse = ""`)
- Auto-reload files on focus/buffer change

### Auto Filetype Detection

- Automatically detects filetype for unnamed buffers based on content
- Supported formats: JSON, XML, YAML
- Triggers on BufEnter, BufReadPost, TextChanged, and TextChangedI events
- Enables syntax highlighting without manual filetype setting
- `.env` files are set to `sh` filetype for syntax highlighting, but excluded from shellcheck linting

### Theme & UI

- Base theme: vscode_dark
- Custom visual selection background: #484848
- Statusline shows filetype in addition to default modules

## Common Development Workflow

When making changes to this config:

1. **Adding a new plugin**: Create a new file in `lua/plugins/` or add to `lua/plugins/init.lua`
2. **Configuring a plugin**: Create config in `lua/configs/` and reference it from plugin spec
3. **Adding keymaps**: Add to `lua/mappings.lua` (loads NvChad mappings first)
4. **Adding autocommands**: Add to `lua/autocmds.lua` (loads NvChad autocmds first)
5. **Changing vim options**: Modify `lua/options.lua` (extends NvChad options)
6. **Changing theme/UI**: Modify `lua/chadrc.lua`

## Important Notes

- This config extends NvChad defaults - always call `require "nvchad.*"` before custom config in options/mappings/autocmds
- Plugin specs use lazy.nvim syntax
- Format on save is intentionally disabled
- Sign column and gitsigns can be toggled (commented code exists in options.lua)
- The config expects certain external tools: jq, jwt-cli, xmllint, glow, shfmt, shellcheck, yamllint, markdownlint, stylua, prettier, yq
- LSP servers, formatters, and linters are installed via Mason — keep `lua/configs/lspconfig.lua`, `conform.lua`, and `lint.lua` in sync with what's actually installed
