return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function ()
      local conf = require "nvchad.configs.telescope"
      conf.defaults.file_ignore_patterns = {
        "package%-lock.json",
        "package.json",
        "node_modules",
        "test",
        "mtest"
      }
      return conf
    end
  }
}
