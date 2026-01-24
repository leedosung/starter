-- ~/.config/nvim/lua/configs/treesitter.lua

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "json",
    "javascript",
    "typescript",
    "bash",
    "markdown",
    "markdown_inline",
    "yaml",
    "dockerfile",
    "toml",
    "go",
    "python",
    "rust",
    "c",
    "cpp",
    "sql",
    "hcl",
    "graphql",
    "prisma",
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  -- Treesitter 기반 코드 폴딩 활성화
  fold = {
    enable = true,
  },
})

