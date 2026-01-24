-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",

  hl_override = {
    Visual = {
      bg = "#484848",  -- 원하는 색상
      fg = "NONE",
    }
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
  }
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "filetype", "cwd", "cursor" },
    modules = {
      filetype = function()
        local ft = vim.bo.filetype
        if ft == "" then
          return ""
        end
        return " " .. ft .. " "
      end,
    },
  },
}

-- M.nvdash = { load_on_startup = true }

return M
