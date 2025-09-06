require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP format" })

map("i", "jk", "<ESC>")
map("n", "<Leader>jf", "<cmd>%!jq<cr>", { desc = "Format JSON" })
map("n", "<Leader>jc", "<cmd>%!jq -c<cr>", { desc = "Minify JSON" })

map("n", "<Leader>xf", "<cmd>%!xmllint --format -<cr>", { desc = "Format XML" })
map("n", "<Leader>xc", "<cmd>%!xmllint --noblanks -<cr>", { desc = "Minify XML" })

map("n", "<Leader>fr", "<cmd>Telescope resume<cr>", { desc = "Telescope resume" })

map("n", "<Leader>mv", "<cmd>vsplit | term glow %<cr>", { desc = "Markdown view" })

map("n", "<leader>h", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "horizontal terminal" })
map("n", "<leader>v", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "vertical terminal" })
map("n", "<leader>o", "<cmd>ToggleTerm direction=float size=80<CR>", { desc = "flaot terminal" })

local show_other_diagnostics = false

map("n", "<Leader>l", function()
  if show_other_diagnostics then
    vim.diagnostic.config({
      virtual_text = {
        severity = {
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR,
        },
      },
      signs = false,
      underline = true,
    })
    vim.opt.signcolumn = "no"
  else
    vim.diagnostic.config({
      virtual_text = {
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
      },
      signs = true,
      underline = true,
    })
    vim.opt.signcolumn = "yes"
  end
  show_other_diagnostics = not show_other_diagnostics
end, { desc = "toggle error message (errors/hints)" })

-- terminal mode mappings
local term_opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  pattern = "term://*",
  command = "startinsert"
})

local function smart_move(cmd)
  local mode = vim.api.nvim_get_mode().mode
  if mode == "t" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true), "n", true)
  end
  vim.cmd("wincmd " .. cmd)
end

map("n", "<C-h>", function() smart_move("h") end, term_opts)
map("n", "<C-j>", function() smart_move("j") end, term_opts)
map("n", "<C-k>", function() smart_move("k") end, term_opts)
map("n", "<C-l>", function() smart_move("l") end, term_opts)
map("t", "<C-h>", function() smart_move("h") end, term_opts)
map("t", "<C-j>", function() smart_move("j") end, term_opts)
map("t", "<C-k>", function() smart_move("k") end, term_opts)
map("t", "<C-l>", function() smart_move("l") end, term_opts)

map("n", "<leader>ti", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  local cmd = "tig " .. vim.fn.shellescape(file)
  vim.cmd("tabnew") -- 하단 스플릿 열기
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
end, { desc = "Tig: Git history of current file" })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    vim.keymap.set("t", "<Esc>", function()
      vim.cmd([[stopinsert]])
      vim.cmd([[tabclose]])
    end, { buffer = buf, silent = true })
  end,
})
