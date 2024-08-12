vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Adding the side numbers
opt.relativenumber = true
opt.number = true

-- Configuring tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one
opt.wrap = true -- enable line wrapping (true by default)

-- Setting search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case => assumes we want case-sensitive

-- Changing editor settings
opt.cursorline = true

-- Making so that the colors work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be either light or dark will be dark by default
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Backspace tweaks
opt.backspace = "indent,eol,start" -- allows backspace on indent, end of line or insert mode start position

-- Clipboard tweaks
opt.clipboard:append("unnamedplus") -- uses system clipboard as default register

-- Configuring split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Disabling mouse
opt.mouse = ""
