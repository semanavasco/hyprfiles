return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000, -- loads before everything else
	config = function()
		vim.cmd("colorscheme tokyonight")
	end,
}
