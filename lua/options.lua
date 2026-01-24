require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
vim.opt.whichwrap = "b,s"
vim.opt.mouse = ""
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "if mode() != 'c' | checktime | endif",
})
-- vim.opt.mouse = "a"
-- vim.opt.clipboard = "unnamedplus"

-- gitsigns disable
-- vim.opt.signcolumn = "no"
