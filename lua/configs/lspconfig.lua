-- require("nvchad.configs.lspconfig").defaults()
-- local servers = { "html", "cssls", "ts_ls", "eslint", "jsonls", "bashls", "clangd", "yamlls" }
-- vim.lsp.enable(servers)

-- local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  })
end

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "clangd",
  "eslint",
  "jsonls",
  "bashls",
  "yamlls",
  "marksman",
  "lua_ls",
  "rust_analyzer",
  "ansiblels",
  "terraformls",
  "graphql",
  "prismals",
  "dockerls",
  "taplo",
  "sqlls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
