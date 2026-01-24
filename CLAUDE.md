# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration based on NvChad v2.5. NvChad is used as a plugin (imported from NvChad/NvChad), with custom configurations extending its base functionality. The configuration follows NvChad's modular structure where you import base modules and override/extend them.

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
Enabled LSP servers: html, cssls, ts_ls, eslint, clangd, jsonls, bashls, yamlls, marksman, lua_ls, terraformls, dockerls

### Formatters (lua/configs/conform.lua)
- Lua: stylua
- JS/TS: prettier
- JSON: prettier, jq
- YAML: prettier, yq
- Markdown: prettier, markdownlint
- Shell: shfmt

Format on save is disabled by default (commented out in conform.lua).

### Treesitter Parsers (lua/configs/treesitter.lua)
Auto-installs parsers for: vim, lua, html, css, json, javascript, typescript, bash, markdown, yaml, dockerfile, toml, go, python, rust, c, cpp, sql, hcl, graphql, prisma

Modules enabled:
- `highlight`: Syntax highlighting
- `indent`: Smart indentation
- `fold`: Code folding support

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

**Avante** (lua/plugins/avante.lua) - Currently disabled
- Configured for Claude Sonnet 4 and Moonshot Kimi K2
- Instructions file: avante.md (if exists)

**Copilot** (lua/plugins/copilot.lua) - Enabled
- Integrated with nvim-cmp for completions
- Suggestion and panel UI disabled in favor of cmp integration

### Terminal & Git Integration

**ToggleTerm** keymaps:
- `<leader>h` - Horizontal terminal
- `<leader>v` - Vertical terminal (width: 60)
- `<leader>o` - Float terminal (size: 80)

**Git Integration**:
- `<leader>gh` - Git file history (Diffview - read-only, safe)

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
- The config expects certain external tools: jq, jwt-cli, xmllint, glow, shfmt