local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },

  sh = { "shellcheck" },
  bash = { "shellcheck" },

  yaml = { "yamllint" },
  yml = { "yamllint" },

  json = { "jsonlint" },

  markdown = { "markdownlint" },
}
