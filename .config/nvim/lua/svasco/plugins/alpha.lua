return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Configuring the header
		dashboard.section.header.val = {
			"              .........",
			"            .'------.' |",
			"           | .-----. | |",
			"           | |   | | |        ==",
			"         __| |  󰓇 | | |;. ____|--|_______",
			"        /  |*`-----'.|.' `;    |__|   󰇥  //",
			"       /   `---------' .;'          󱕴   //|",
			" /|   /  .''''////////;'               //||",
			"|=|  .../ ######### /;/    __         // ||",
			"|/  /  / ######### //     /'/        //| ||",
			"   /   `-----------'                // | ||",
			"  /________________________________//  | ||",
			"  `--------------------------------'   | ||",
			"   : | ||      | ||            | ||    | ||",
			'   : | ||      | ||            | ||    `""\'',
			'     | ||      `""\'            | ||',
			"     | ||                      | ||",
			"     | ||                      | ||",
			'     `""\'                      `""\'',
		}

		-- Configuring the menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("[_] ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("[_] ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("[_] fs", "  > Find String", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("[_] wr", "󰁯  > Restore Session for Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Changing colors
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaButtons"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		-- Sending our config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
