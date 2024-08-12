-- Setting leader key to SPACE
vim.g.mapleader = " "

local keymap = vim.keymap

-- Switch from insert mode to normal mode
keymap.set("i", "jk", "<ESC>", { desc = "Exits insert mode with jk." })

-- Clear the search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clears search highlights." })

-- Setting window management keybinds
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Splits window vertically." })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Splits window horizontally." })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Makes the splits equal size." })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Closes the current split." })

-- Setting tab management keybinds
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Opens a new tab." })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Closes the current tab." })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Goes to the next tab." })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Goes to the previous tab." })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Opens the current buffer in a new tab." })
