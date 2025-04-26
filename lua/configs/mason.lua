-- ~/.config/nvim/lua/configs/mason.lua
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "ts_ls",   -- typescript/javascript
    "bashls",     -- bash
    "lua_ls",     -- lua
    "html",       -- html
    "cssls",      -- css
    "jsonls",     -- json
    "eslint",     -- eslint
    "yamlls",     -- yaml
    "marksman",   -- markdown
    "pyright",    -- python
    "rust_analyzer", -- rust
    "dockerls",   -- dockerfile
    "ansiblels",  -- ansible
    "terraformls", -- terraform
    "graphql",    -- graphql
    "prismals",   -- prisma
    "taplo",      -- toml
    "sqlls",      -- sql
    -- "typescript-language-server",
    -- "bash-language-server",
    -- "lua-language-server",
    -- "stylua",
    -- "html-lsp",
    -- "css-lsp",
    -- "json-lsp",
    -- "eslint-lsp",
    -- "prettier",
    -- "shfmt",
    -- "shellcheck",
    -- "yaml-language-server",
    -- "yamllint",
    -- "jsonlint",
    -- "markdownlint",
    -- "jq",
    -- "yq",
    -- "eslint_d",
    -- "marksman",
    -- "pyright",
    -- "rust-analyzer",
    -- "dockerls",
    -- "docker-compose-language-service",
    -- "ansible-language-server",
    -- "terraform-ls",
    -- "graphql-language-service-cli",
    -- "prisma-language-server",
    -- "taplo",
    -- "sqlls",
  },
  automatic_installation = true,
})

