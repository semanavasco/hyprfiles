return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		-- Setting custom keymaps
		local keymap = vim.keymap

		keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files<CR>",
			{ desc = "Fuzzy finds files in the current working directory." }
		)
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy finds recent files." })
		keymap.set(
			"n",
			"<leader>fs",
			"<cmd>Telescope live_grep<CR>",
			{ desc = "Finds strings in the current working directory." }
		)
		keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<CR>",
			{ desc = "Finds matching strings with cursor word." }
		)
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Finds TO-DOs." })
	end,
}
