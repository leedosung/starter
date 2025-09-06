local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },

    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    json = { "prettier", "jq" },
    yaml = { "prettier", "yq" },
    yml = { "prettier", "yq" },

    markdown = { "prettier", "markdownlint" },

    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
