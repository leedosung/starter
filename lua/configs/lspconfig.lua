require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls", -- typescript-language-server
  "eslint", -- eslint_d
  "clangd",
  "jsonls",
  "bashls",
  "yamlls",
  "marksman",
  "lua_ls",
  "terraformls",
  "dockerls"
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
