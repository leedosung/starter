require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "prettier",
    "shfmt",
    "shellcheck",
    "yamllint",
    "jsonlint",
    "markdownlint",
    "jq",
    "yq",
    "eslint_d",
  },
  automatic_installation = true,
})

