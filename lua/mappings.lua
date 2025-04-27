require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>jf", "<cmd>%!jq<cr>", { desc = "Format JSON" })
map("n", "<Leader>jc", "<cmd>%!jq -c<cr>", { desc = "Minify JSON" })

map("n", "<Leader>xf", "<cmd>%!xmllint --format -<cr>", { desc = "Format XML" })
map("n", "<Leader>xc", "<cmd>%!xmllint --noblanks -<cr>", { desc = "Minify XML" })

map("n", "<Leader>fr", "<cmd>Telescope resume<cr>", { desc = "Telescope resume" })

-- map("n", "<Leader>da", "<cmd>windo diffthis<cr>", { desc = "Buffer all windows diff" })
-- map("n", "<Leader>do", "<cmd>windo diffoff<cr>", { desc = "Buffer all windows diff off" })
-- map("n", "<Leader>du", "<cmd>windo diffupdate<cr>", { desc = "Buffer all windows diff update" })

map("n", "<Leader>mv", "<cmd>vsplit | term glow %<cr>", { desc = "Markdown view" })

-- map("n", "<Leader>s", function()
--   local current = vim.diagnostic.config().virtual_text
--   vim.diagnostic.config({ virtual_text = not current })
-- end, { desc = "Toggle virtual text (errors/hints)" })

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
  end
  show_other_diagnostics = not show_other_diagnostics
end, { desc = "Toggle other diagnostics (errors always on)" })

