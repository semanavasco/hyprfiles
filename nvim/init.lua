require("svasco.core")
require("svasco.lazy")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local fg_color = "#CBA6F7"
		local hi_header = "hi AlphaHeader guifg=" .. fg_color
		local hi_button = "hi AlphaButtons guifg=" .. fg_color

		vim.cmd(hi_header)
		vim.cmd(hi_button)
	end,
})
