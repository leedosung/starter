require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>jq", "<cmd>%!jq<cr>", { desc = "Format JSON" })
map("n", "<Leader>jc", "<cmd>%!jq -c<cr>", { desc = "Format JSON (compact)" })
