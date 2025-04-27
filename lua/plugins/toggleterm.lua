return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup{
        size = 10,
        open_mapping = [[<c-\>]],
        -- direction = "float",
        direction = "horizontal",
        float_opts = {
          border = "curved",
        },
      }
    end,
  },
}
