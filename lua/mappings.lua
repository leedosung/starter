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

map("n", "<Leader>da", "<cmd>windo diffthis<cr>", { desc = "Buffer all windows diff" })
map("n", "<Leader>do", "<cmd>windo diffoff<cr>", { desc = "Buffer all windows diff off" })
map("n", "<Leader>du", "<cmd>windo diffupdate<cr>", { desc = "Buffer all windows diff update" })
