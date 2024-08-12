return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- treesitter's configuration
		treesitter.setup({
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			highlight = { enable = true, disable = { "latex" } },
			indent = { enable = true },
			autotag = { enable = true }, -- requires nvim-ts-autotag

			-- ensure these language servers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"yaml",
				"html",
				"css",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"gitignore",
				"c",
				"cpp",
				"elixir",
				"eex",
				"heex",
				"python",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			modules = {},
		})
	end,
}
