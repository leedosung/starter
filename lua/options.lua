require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Mason bin 디렉토리를 PATH에 추가 (conform.nvim이 포맷터를 찾을 수 있도록)
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

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
