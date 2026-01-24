return {
  {
    "greggh/claude-code.nvim",
    enabled = false,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("claude-code").setup()
    end
  }
}
